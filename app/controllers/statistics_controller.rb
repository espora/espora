class StatisticsController < ApplicationController

	# Incluir las funciones de ayuda de estadisticas
	include StatisticsHelper

	# Layout de terapeuta
	layout "therapist", :only => [ :index ]

	# Settings
	require "statistics_chart"

	def index

		# Sede
		if params[:branch].nil?
			@branch = current_therapist.branch
		else
			@branch = Branch.find(params[:branch])
		end
		@branch_options = get_branch_options(@branch)

		# Semestre
		if params[:semester].nil?
			@semester = "2015-1"
		else
			@semester = params[:semester]
		end
		@semester_options = get_semester_options(params[:semester])

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 0

		# Panel para las tabs del workspace del perfil
		@profile_active_tab = 1
	end

	def chart

		# Nombre del metodo para obtener los datos
		method_name = params[:chart] + "_data"

		# Verifica si existen datos para esa grafica
		if respond_to?(method_name, true)
			branch = Branch.find(params[:branch])

			@chartSetting = StatisticsChart::settings[params[:chart]]
			@chartSetting[:dataTable] = send(method_name, branch, params[:semester])
		else
			@chartSetting = "undefinedchart"
		end

		# Rendereamos el parcial para graficas
		render partial: "chart"
	end

	private

		def get_branch_options (branch)
			branch_options = ""

			# Coordinador -> solo puede elegir su propia sede 
			if current_therapist.role === "Coordinador"
				branch_options += "<option value='" + branch.id.to_s + "' selected> " + branch.name + "</option>"
			elsif current_therapist.role === "Administrador"
			end

			return branch_options
		end

		def get_semester_options (semester)
			return "<option value='2015-1' selected>Semestre 2015-1</option>"
		end

		def last_init_semester(date)
			month = date.month
			day = date.day - 1
			diff = 0

			if 1 <= month and month <= 6
				diff = month - 1
			elsif 7 <= month and month <= 12
				diff = month - 7
			end

			return (date - diff.month) - day.day
		end

		###############
		# CHARTS DATA #
		###############
		
		def request_on_attended_data (branch, semester)
			init = last_init_semester(Time.now) - 18.month
			now = Time.now

			# Selecciona las solicitudes
			patient_requests = PatientRequest.joins(patient: { career: :branch })
			.where("branches.id = ?", "#{branch.id}")
			.where(:created_at => init..now)

			# Iteramos las solicitudes y creamos un auxiliar
			dataTmp = Hash.new 
			patient_requests.each do | request |

				# Obtenemos el semestre en que fue hecha la solicitud
				semester = get_semester(request.request_date)

				# Creamos si no esta
				if dataTmp[semester].nil?
					dataTmp[semester] = Hash.new
					dataTmp[semester][:request] = 0
					dataTmp[semester][:attended] = 0
				end

				# Sumamos en 1 el contador de solicitudes
				dataTmp[semester][:request] += 1

				# Si ya tiene una fecha de atencion es que fue atendido
				if not request.attention_date.nil?

					# Obtenemos el semestre en que fue atendida la solicitud
					semester = get_semester(request.request_date)

					# Creamos si no esta
					if dataTmp[semester].nil?
						dataTmp[semester] = Hash.new
						dataTmp[semester][:request] = 0
						dataTmp[semester][:attended] = 0
					end

					# Sumamos en 1 el contador de solicitudes
					dataTmp[semester][:attended] += 1
				end
			end

			# Creamos la tabla de datos
			dataTable = [['String', 'Numero de Solicitudes Recibidas', 'Numero de Alumnos Atendidos']]
			dataTmp.each do |key, value|
				row = ['Semestre ' + key, value[:request], value[:attended]];
				dataTable << row
			end
			
			return dataTable
		end
end
