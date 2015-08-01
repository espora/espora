class StadisticsController < ApplicationController

	# Incluir las funciones de ayuda de estadisticas
	include StadisticsHelper

	# Layout de terapeuta
	layout "therapist", :only => [ :index ]

	def index

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 0

		# Panel para las tabs del workspace del perfil
		@profile_active_tab = 1
	end

	def chart

		# Se construye el nombre del metodo
		method_name = params[:chart] + "_data"
		puts method_name

		# Checamos que solo nos pregunten graficas que
		# podemos responder
		if respond_to?(method_name, true)

			# Se manda a llamar el metodo y se obtienen los datos
			data = send(method_name)

			# Se renderean como json
			render json: data.to_json
		else

			# Se renderea un json con el mensaje que no existe la grafica
			render json: "undefined chart".to_json
		end
	end

	private

		def request_on_attended_data

			# Todas las solicitudes
			patient_requests = PatientRequest.all

			# Creamos el hash de datos
			data = Hash.new

			# Iteramos las solicitudes
			patient_requests.each do | request |

				# Obtenemos el semestre en que fue hecha la solicitud
				semester = get_semester(request.request_date)

				# Creamos si no esta
				if data[semester].nil?
					data[semester] = Hash.new
					data[semester][:request] = 0
					data[semester][:attended] = 0
				end

				# Sumamos en 1 el contador de solicitudes
				data[semester][:request] += 1

				# Si ya tiene una fecha de atencion es que fue atendido
				if not request.attention_date.nil?

					# Obtenemos el semestre en que fue atendida la solicitud
					semester = get_semester(request.request_date)

					# Creamos si no esta
					if data[semester].nil?
						data[semester] = Hash.new
						data[semester][:request] = 0
						data[semester][:attended] = 0
					end

					# Sumamos en 1 el contador de solicitudes
					data[semester][:attended] += 1
				end
			end

			# Regresamos los datos
			return data
		end

		def sex_requests_data

			# Consultamos la base
			data = PatientRequest.joins(:patient).group(:sex).count

			return data
		end

		def sex_attended_data
			
			# Consultamos la base
			data = PatientRecord.joins(:patient).group(:sex).count

			return data
		end

		#def family_structure_data

		#end

		def career_requests_data
			
			data = PatientRequest.joins(:patient).group(:career).count

			return data
		end

		def career_attended_data
			
			data = PatientRecord.joins(:patient).group(:career).count

			return data
		end

        def semester_requests_data
        	
        	data = PatientRequest.joins(:patient).group(:semester).count

        	return data
        end

        def semester_attended_data

        	data = PatientRecord.joins(:patient).group(:semester).count

        	return data
        end

        def failed_subjects_requests_data
        	
        	data = PatientRequest.joins(:patient).group(:failed_subjects).count

        	return data
        end

        def failed_subjects_attended_data
        	
        	data = PatientRecord.joins(:patient).group(:failed_subjects).count

        	return data
        end

        #def dropouts_semester_data
        	
        #end

        def dropouts_data

        	data = PatientDropout.joins(:patient_dropout_type).group(:name).count

        	return data
        end

        def reasons_data
        	
        	data = Reason.joins(:reasons_type).group(:name).count

        	return data
        end

        #def symptoms_data
        	
        #end

        def affected_areas_data
        
        	data = AffectedArea.joins(:personal_area_type).group(:name).count

        	return data	
        end

        def improved_areas_data
        	
        	data = ImproveArea.joins(:personal_area_type).group(:name).count
	
			return data
        end

        def condition_before_data
        
        	data = PatientRequest.joins(:condition_type).group(:name).count

        	return data	
        end

        def condition_after_data

        	data = PatientSignout.joins(:condition_type).group(:name).count

        	return data
        end

        def aid_data
        
        	data = PatientSignout.joins(:aid_level_type).group(:name).count

        	return data	
        end

        def advise_data
        	
        	data = PatientSignout.joins(:advise_level_type).group(:name).count

        	return data	
        end

        def how_met_data
        
        	data = HowMet.joins(:how_met_type).group(:name).count

        	return data	
        end

        def rating_data
        
        	data = PatientSignout.group(:rating).count

        	return data	
        end

end
