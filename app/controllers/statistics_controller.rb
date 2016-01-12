class StatisticsController < ApplicationController

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
			@semester = get_semester(Time.now)
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

			settings = StatisticsChart.settings()
			@chartSetting = settings[params[:chart]]
			@chartSetting[:dataTable] = send(method_name, branch, params[:semester])

			ap "Sending..."
			ap @chartSetting[:dataTable]
		else
			@chartSetting = "undefinedchart"
		end

		# Rendereamos el parcial para graficas
		render partial: "chart"
	end

	private

		def get_semester(date)
			month = date.month
			year = date.year

			# Ene - Jun
			if 1 <= month and month <= 6
				semester = year.to_s + "-2"

			# Jul - Dic
			elsif 7 <= month and month <= 12
				semester = (year + 1).to_s + "-1"
			end

			return semester
		end

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
			date = PatientRequest.all.order("patient_requests.request_date ASC").first.request_date
			now = Time.now
			semester_options = ""

			while date < now do
				semester_str = get_semester(date)

				semester_options += "<option value='#{semester_str}' "
				semester_options += "selected" if semester_str === semester
				semester_options += ">Semestre #{semester_str}</option>"

				date = date + 6.month
			end

			return semester_options
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

		def parse_semester(semester)
			year = semester.split("-")[0].to_i
			num = semester.split("-")[1].to_i

			if num == 1
				date = Time.new(year - 1, 7, 1)
			else
				date = Time.new(year, 1, 1)
			end

			return date
		end

		###############
		# CHARTS DATA #
		###############
		
		def request_on_attended_data(branch, semester)
			now = Time.now

			initDate = last_init_semester(now) - 18.month
			endDate = (get_semester(now) == semester) ? now : parse_semester(semester) + 6.month

			# Selecciona las solicitudes
			patient_requests = PatientRequest.joins(patient: { career: :branch })
			.where("branches.id = ?", "#{branch.id}")
			.where(:request_date => initDate..endDate)

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
			dataTmp.keys.sort!.each do |key|
				row = ['Semestre ' + key, dataTmp[key][:request], dataTmp[key][:attended]];
				dataTable << row
			end
			
			return dataTable
		end

		def sex_requests_data(branch, semester)
			initDate = parse_semester(semester)
			endDate = initDate + 6.month

			# Selecciona las solicitudes
			dataTmp = PatientRequest.joins(patient: { career: :branch })
			.where("branches.id = ?", "#{branch.id}")
			.where(:request_date => initDate..endDate)
			.group(:sex).count

			# Creamos la tabla de datos
			dataTable = [['Genero', 'Personas']]
			if dataTmp["m"].nil?
				dataTable << ['Hombre', 0]
			else
				dataTable << ['Hombre', dataTmp["m"]]
			end

			if dataTmp["f"].nil?
				dataTable << ['Mujer', 0]
			else
				dataTable << ['Mujer', dataTmp["f"]]
			end

			return dataTable
		end

		def sex_attended_data(branch, semester)
			initDate = parse_semester(semester)
			endDate = initDate + 6.month
			
			# Consultamos la base
			dataTmp = PatientRecord.joins(patient: { career: :branch })
			.where("branches.id = ?", "#{branch.id}")
			.where(:created_at => initDate..endDate)
			.group("patients.sex").count

			# Creamos la tabla de datos
			dataTable = [['Genero', 'Personas']]
			if dataTmp["m"].nil?
				dataTable << ['Hombre', 0]
			else
				dataTable << ['Hombre', dataTmp["m"]]
			end

			if dataTmp["f"].nil?
				dataTable << ['Mujer', 0]
			else
				dataTable << ['Mujer', dataTmp["f"]]
			end

			return dataTable
		end

		def career_requests_data(branch, semester)
			initDate = parse_semester(semester)
			endDate = initDate + 6.month
			
			# Consulta a la base
			dataTmp = PatientRequest.joins(patient: { career: :branch })
			.where("branches.id = ?", "#{branch.id}")
			.where(:request_date => initDate..endDate)
			.group("careers.name").count
			
			# Creamos la tabla de datos
			dataTable = [['Carrera', 'Personas']]
			dataTmp.each do | key, value |
				dataTable << [ key, value ]
			end

			return dataTable
		end

		def career_attended_data(branch, semester)
			initDate = parse_semester(semester)
			endDate = initDate + 6.month

			# Consultamos la base
			dataTmp = PatientRecord.joins(patient: { career: :branch })
			.where("branches.id = ?", "#{branch.id}")
			.where(:created_at => initDate..endDate)
			.group("careers.name").count
			
			# Creamos la tabla de datos
			dataTable = [['Carrera', 'Personas']]
			dataTmp.each do | key, value |
				dataTable << [ key, value ]
			end

			return dataTable
		end

		def semester_requests_data(branch, semester)
			initDate = parse_semester(semester)
			endDate = initDate + 6.month

			# Consulta a la base
			dataTmp = PatientRequest.joins(patient: { career: :branch })
			.where("branches.id = ?", "#{branch.id}")
			.where(:request_date => initDate..endDate)
			.group(:semester).count
			
			# Creamos la tabla de datos
			dataTable = [['Semetre', 'Personas']]
			dataTmp.each do | key, value |
				dataTable << [ "Semestre " + key.to_s, value ]
			end

			return dataTable
		end

		def semester_attended_data(branch, semester)
			initDate = parse_semester(semester)
			endDate = initDate + 6.month

			# Consultamos la base
			dataTmp = PatientRecord.joins(patient: { career: :branch })
			.where("branches.id = ?", "#{branch.id}")
			.where(:created_at => initDate..endDate)
			.group("patients.semester").count
			
			# Creamos la tabla de datos
			dataTable = [['Semetre', 'Personas']]
			dataTmp.each do | key, value |
				dataTable << [ "Semetre " + key.to_s, value ]
			end

			return dataTable
		end

		def failed_subjects_requests_data(branch, semester)
			initDate = parse_semester(semester)
			endDate = initDate + 6.month
			
			# Consulta a la base
			dataTmp = PatientRequest.joins(patient: { career: :branch })
			.where("branches.id = ?", "#{branch.id}")
			.where(:request_date => initDate..endDate)
			.group(:failed_subjects).count
			
			# Creamos la tabla de datos
			dataTable = [['Número de materias', 'Personas']]
			dataTmp.each do | key, value |
				dataTable << [ key.to_s, value ]
			end

			return dataTable
		end

		def failed_subjects_attended_data(branch, semester)
			initDate = parse_semester(semester)
			endDate = initDate + 6.month

			# Consulta a la base
			dataTmp = PatientRecord.joins(patient: { career: :branch })
			.where("branches.id = ?", "#{branch.id}")
			.where(:created_at => initDate..endDate)
			.group(:failed_subjects).count
			
			# Creamos la tabla de datos
			dataTable = [['Número de materias', 'Personas']]
			dataTmp.each do | key, value |
				dataTable << [ key.to_s, value ]
			end
			
			return dataTable
		end

		def dropouts_data

			# Consultamos la base
			data = PatientDropout.joins(:patient_dropout_type).group(:name).count
			return data
		end
end
