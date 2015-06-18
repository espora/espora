module ApplicationHelper

	# Obtiene los expedientes abiertos
	# guardados en sesion
	def open_records

		# Crea un arreglo
		@open_records = Array.new

		# Si está el registro en la sesion
		if not session[:open_records].nil?

			# Itera los identificadores de los expedientes abiertos y
			# lo mete en el arreglo
			session[:open_records].each do | key, value |
				@open_records << PatientRecord.find(value[:id])
			end
		end

		return @open_records
	end

	# Obtiene las citas abiertas de un expediente
	# guardado en sesion
	def open_appointments (patient_record)

		# Crea un arreglo
		@open_appointments = Array.new

		# Si está el registro en la sesion
		if not session[:open_records][patient_record.id.to_s].nil?

			# Itera los identificadores de las citas abiertas
			# y lo mete en el arreglo
			session[:open_records][patient_record.id.to_s][:open_appointments].each do | value |
				@open_appointments << Appointment.find(value)
			end
		end
		
		return @open_appointments
	end

end