class HomeController < ApplicationController

	# GET
	# Pagina principal del proyecto, si el terapeuta
	# esta logeado, redirigimos a su perfil.
	def index

		# Si el terapeuta esta logeado
		if therapist_signed_in?

			# Redirigimos a su perfil
			redirect_to therapist_profile_path(current_therapist.id)
		end
	end

end