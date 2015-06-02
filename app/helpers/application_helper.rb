module ApplicationHelper

	def age (birthday)
		now = Time.now.utc.to_date
		return now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
	end

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

	def open_records
		@open_records = Array.new

		if not session[:open_records].nil?
			session[:open_records].each do | key, value |
				@open_records << PatientRecord.find(value[:id])
			end
		end

		return @open_records
	end

	def open_appointments (patient_record)
		@open_appointments = Array.new

		if not session[:open_records][patient_record.id.to_s].nil?
			session[:open_records][patient_record.id.to_s][:open_appointments].each do | value |
				@open_appointments << Appointment.find(value)
			end
		end
		
		return @open_appointments
	end

end