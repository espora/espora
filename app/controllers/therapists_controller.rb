class TherapistsController < ApplicationController

	# Devise - Verifica que el terapeuta este loggeado
	before_filter :authenticate_therapist!

	# Layout de terapeuta
	layout "therapist"

	# GET
	# Administracion de terapeutas
	def index

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 4

		# Panel para las tabs del workspace de la administracion de terapeutas
		@therapist_admin_active_tab = 0
	end

	# GET
	# Perfil del terapeuta
	def profile

		# Obtenemos el terapeuta
		@therapist = Therapist.find(params[:id])

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 0

		# Panel para las tabs del workspace del perfil
		@profile_active_tab = 0
	end

	# GET
	# Formulario para crear un nuevo terapeuta
	def new

		# Creamos el objeto
		@therapist = Therapist.new

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 4

		# Panel para las tabs del workspace de la administracion de terapeutas
		@therapist_admin_active_tab = 1
	end

	# POST
	# Crea un registro de terapeuta
	def create
		ap params

		# Creamos el terapeuta
		@therapist = Therapist.new(therapist_params)

		# Checamos si es valido
		if @therapist.valid?

			# La sede es la misma del que lo creo
			@therapist.branch = current_therapist.branch

			# Guardamos
			@therapist.save

			# Mandamos a renderear de nuevo con mensaje
			flash[:notice] = { :therapist => "¡Ha registrado exitosamente un terapeuta!" }

			# Redirigimos a la lista de terapeutas
			redirect_to therapists_path
		else

			# Panel para las tabs del workspace del terapeuta
			@therapist_active_tab = 4

			# Panel para las tabs del workspace de la administracion de terapeutas
			@therapist_admin_active_tab = 1

			# Rendereamos de nuevo el formulario
			render :new
		end
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

	private

		# Ecapsula los parametros permitidos para un terapeuta
		def therapist_params
			params.require(:therapist).permit(:names, :p_last_name, :m_last_name,
				:scholar_grade, :telephone1, :telephone2, :email, :password, :password_confirmation,
				:therapist_schedules_attributes => [ :day, :beginH, :endH, :_destroy, :id ])
		end
end