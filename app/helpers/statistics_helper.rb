module StatisticsHelper

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

end