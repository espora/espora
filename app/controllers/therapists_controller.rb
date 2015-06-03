class TherapistsController < ApplicationController

	# Devise - Verifica que el terapeuta este loggeado
	before_filter :authenticate_therapist!

	# Layout de terapeuta
	layout "therapist"

	# GET
	# Perfil del terapeuta
	def profile

		# Obtenemos el terapeuta
		@therapist = Therapist.find(params[:id])

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 0
	end

	# GET
	# Formulario para crear un nuevo terapeuta
	def new

		# Creamos el objeto
		@therapist = Therapist.new

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 3
	end

	# POST
	# Crea un registro de terapeuta
	def create
	end

	# GET
	# Obtiene los horarios de un terapeuta
	def schedules

		# Obtenemos al terapeuta
		therapist = Therapist.find(params[:id])

		# Obtenemos los horarios
		therapist_schedules = therapist.therapist_schedules

		render json: therapist_schedules
	end
end