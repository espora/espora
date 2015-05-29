module PatientRequestsHelper

	def affected_area_inputs (change_function_js)
		html_str = ""
		AffectedAreaType.all.each do | affarea |
			html_str += "<div style='width: 50%; float: left; margin-top: 7px; height: 16px;'>"
			html_str += "<input type='checkbox' id-area='#{affarea.id}' area='#{affarea.name}' onclick='#{change_function_js}(this);'>"
			html_str += "<div style='display: inline-block; position: relative; top: -3px; left: 3px;'>#{affarea.name}</div>"

			if affarea.is_other?
				html_str += "<input type='text' style='display: inline-block; position: relative; top: -3px; left: 8px;'"
				html_str += "autofocus='autofocus' size='10' disabled/>"
			end
			html_str += "</input>"

			html_str += "</div>"
		end

		return html_str.html_safe
	end

	def table_schedules_input

		html_str = "<table id='req-schedules-input' class='pure-table pure-table-bordered pat-schedule-table noselect'>"
		html_str += "<col width='115px'/><col width='40px'/><col width='40px'/><col width='40px'/><col width='40px'/><col width='40px'/>"
		html_str += "<thead><tr align='center'>"
		html_str += "<th style='width: 55px;'>Hora</th>"
		html_str += "<th>Lun.</th>"
		html_str += "<th>Mar.</th>"
		html_str += "<th>Mié.</th>"
		html_str += "<th>Jue.</th>"
		html_str += "<th>Vie.</th>"
		html_str += "</tr></thead>"
		html_str += "<tbody>"

		# 7am a 10pm
		(10..22).each do |hour|

			# Intervalo de 30 minutos
			["00", "30"].each do |minutes|

				# Obtenemos la siguiente hora
				next_minutes = (minutes.to_i + 30) % 60
				next_hour = (next_minutes == 0)? (hour + 1) : hour

				# Creamos el codigo html para el tr
				tr_str = "<tr><td align='center'>"
				tr_str += "0" if hour.to_s.length == 1
				tr_str += hour.to_s
				tr_str += ":"
				tr_str += minutes
				tr_str += " - "
				tr_str += "0" if next_hour.to_s.length == 1
				tr_str += next_hour.to_s
				tr_str += ":"
				tr_str += "0" if next_minutes.to_s.length == 1
				tr_str += next_minutes.to_s
				tr_str += " hrs.</td>"

				# Iteramos los días
				5.times do | day |

					# Obtenemos el id
					id_td = (day + 1).to_s + hour.to_s + minutes

					# Creamos el td
					td_str = "<td id='#{id_td}' class='available-schedule' "
					td_str += "day='#{(day + 1)}' "
					td_str += "hour='#{hour}' minutes='#{minutes}' "
					td_str += "next-hour='#{next_hour}' next-minutes='#{next_minutes}'></td>"

					# Lo agregamos a la fila
					tr_str += td_str
				end

				tr_str += "</tr>"
				html_str += tr_str
			end
		end

		html_str += "</tbody></table>"

		return html_str.html_safe
	end

end
