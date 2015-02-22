module ApplicationHelper

	def age(birthday)
		now = Time.now.utc.to_date
		return now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
	end

end
