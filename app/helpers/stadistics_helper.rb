module StadisticsHelper

	def get_semester(date)

		# Obtenemos el mes y año
		month = date.month
		year = date.year

		# Ene - Julio
		if month >= 1 and month <= 7
			semester = year.to_s + "-2"

		# Ago - Dic
		elsif month >= 8 and month <= 12
			semester = (year + 1).to_s + "-1"
		end

		return semester
	end

end
