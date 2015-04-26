class HomeController < ApplicationController

	def index

		# Si el terapeuta esta logeado
		if therapist_signed_in?

			# Redirigimos a su perfil
			redirect_to therapist_profile_path(current_therapist.id)
		end
	end

end
