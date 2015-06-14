module PatientRequestsHelper

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