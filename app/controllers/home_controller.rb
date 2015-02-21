class HomeController < ApplicationController

	def index
		if therapist_signed_in?
			redirect_to therapist_profile_path(current_therapist.id)
		end
	end

end
