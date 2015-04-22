module ApplicationHelper

	def age(birthday)
		now = Time.now.utc.to_date
		return now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
	end

	def lue_filter_options ( param_filter )
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

	def current_patient
		return unless session[:current_patient_id]
		@current_patient ||= Patient.find(session[:current_patient_id])
	end

	def current_appointment
		return unless session[:current_appointment_id]
		@current_appointment ||= Appointment.find(session[:current_appointment_id])
	end

end