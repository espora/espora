module PatientRequestsHelper

	# Devuelve las opciones disponibles para
	# carrera en base a la sede del terapeuta
	def carrer_options

		# Creamos el arreglo
		options = Array.new

		# Obtenemos las carreras de la sede del terapeuta actual
		careers = current_therapist.branch.careers

		# Metemos las carreras
		careers.each do | career |
			options << [career.name, career.id]
		end

		return options
	end

	# Devuelve las opciones disponibles para inicio
	# de año escolar
	def init_school_years

		# Año de inicio y final
		bYear = 1990
		eYear = 2015

		# Creamos el arreglo
		options = Array.new

		# Iteramos los años y lo llenamos
		(bYear..eYear).each do |year|
			options << [year.to_s, year.to_s]
		end

		return options
	end

	# Devuelve las opciones para filtrar las
	# solicitudes (LUE)
	def lue_filter_options (param_filter)
		default_options = [["No Filtrar", "none"], ["Concidencias en horario", "schedule"]]

		options = ""
		default_options.each do | option |

			if not param_filter.nil?
				if param_filter == option[1]
					options += "<option value='" + option[1] + "' selected> " + option[0] + "</option>"
				else
					options += "<option value='" + option[1] + "'>" + option[0] + "</option>"
				end
			else
				options += "<option value='" + option[1] + "'>" + option[0] + "</option>"
			end
		end

		return options
	end
	
end