module PatientRequestsHelper

	def table_patient_schedule( patient_request )

		html_str = "<table class='pure-table pure-table-bordered pat-schedule-table'>"
		html_str += "<thead><tr>"
		html_str += "<th>Hora</th>"
		html_str += "<th>Lunes</th>"
		html_str += "<th>Martes</th>"
		html_str += "<th>Miércoles</th>"
		html_str += "<th>Jueves</th>"
		html_str += "<th>Viernes</th>"
		html_str += "</tr></thead>"
		html_str += "<tbody>"

		# Hora de inicio 7am
		hour = 7
		min = 0

		# Hasta las 10pm
		while (hour < 22)

			# Obtenemos la siguiente hora
			nextMin = (min + 30) % 60
			nextHour = (nextMin == 0) ? hour + 1 : hour

			# Creamos el codigo html para el tr
			tr_str = "<tr><td align='center'>"
			tr_str += (hour.to_s.length == 1)? ("0" + hour.to_s) : hour.to_s
			tr_str += ":"
			tr_str +=  (min.to_s.length == 1)? (min.to_s + "0") : min.to_s
			tr_str += " hrs.</td>"

			time = TimeOfDay.new(hour, min)
			next_time = TimeOfDay.new(nextHour, nextMin)
			range = Shift.new(time, next_time)

			# One available?
			one_available = false

			# Iteramos los días
			5.times do | day |

				# Sacamos los horarios de ese dia
				day_schedules = patient_request.request_schedules.where(:day => (day + 1))

				# Si esta disponible
				available = false

				# Iteramos esos dias
				day_schedules.each do | day_schedule |

					# Creamos el tod
					begin_schedule = TimeOfDay.new(day_schedule.beginH.hour, day_schedule.beginH.min)
					end_schedule = TimeOfDay.new(day_schedule.endH.hour, day_schedule.endH.min)
					range_schedule = Shift.new(begin_schedule, end_schedule)

					# Preguntamos si se incluye al horario
					if range.include?(begin_schedule) or range.include?(end_schedule) or range_schedule.include?(time) or range_schedule.include?(next_time)
						available = true
						break
					end
				end

				# Ponemos un tache si es que esta disponible
				tr_str += "<td align='center'>"
				if available
					tr_str += "X"
				else
					tr_str += "-"
				end
				tr_str += "</td>"

				one_available = (one_available or available)
			end

			tr_str += "</tr>"

			# Si puede en alguna hora entonces lo agregamos
			if one_available
				html_str += tr_str
			end

			# Actualizamos la hora
			min = ( min + 30 ) % 60
			if min == 0
				hour += 1
			end
		end

		html_str += "</tbody></table>"

		return html_str.html_safe
	end

end
