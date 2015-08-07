class TherapistsController < ApplicationController

	# Devise - Verifica que el terapeuta este loggeado
	before_filter :authenticate_therapist!

	# Layout de terapeuta
	layout "therapist"

	# GET
	# Administracion de terapeutas
	def index

		# Obtenemos el id del terapeuta actual
		curr_id = current_therapist.id

		# Obtenemos el id de la sede del terapeuta actual
		curr_branch = current_therapist.branch_id

		# El Array que se ira llenando
		@therapists = Array.new

		# Nos pasaron un id?
		if not params[:id].nil?

			# Buscamos el terapeuta con el id
			@therapists.concat([ Therapist.find(params[:id]) ])
		end

		# Estan buscando algo?
		if not params[:searchStr].nil?
			if params[:searchStr] == ""

				# Viene vacio, entonces mandamos todas
				@therapists = Therapist.where(branch_id: curr_branch).where.not(id: curr_id)
			else

				# BUSQUEDA

				# Por apellido paterno
				@therapists.concat(Therapist.where("p_last_name LIKE ?", "%#{params[:searchStr]}%"))

				# Por apellido materno
				@therapists.concat(Therapist.where("m_last_name LIKE ?", "%#{params[:searchStr]}%"))

				# Por nombres
				@therapists.concat(Therapist.where("names LIKE ?", "%#{params[:searchStr]}%"))

				# Por id
				@therapists.concat(Therapist.where(id: params[:searchStr]))

				# Eliminamos repetidos
				@therapists.uniq!
			end
		end

		# Si no hubo ninguno hay que solicitar todos
		if params[:id].nil? and params[:searchStr].nil?
			@therapists = Therapist.where(branch_id: curr_branch).where.not(id: curr_id)
		end

		# Hay que ordenar
		if not params[:order_by].nil? and @therapists.size > 0
			case params[:order_by]
			when "branch"
				@therapists.sort! do |x, y|
					x.branch.name <=> y.branch.name
				end
			when "records"
				@therapists.sort! do |x, y|
					x.patient_records.count <=> y.patient_records.count
				end
			else
				@therapists.sort! do |x, y|
					x.attributes[params[:order_by]] <=> y.attributes[params[:order_by]]
				end
			end
		end

		# Convertimos a array
		@therapists = @therapists.to_a

		# Evitamos quedarnos con el que tenga id del terapeuta actual
		@therapists.keep_if do | ther |
			ther.id != curr_id
		end

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
	# Formulario para editar a un terapeuta
	def edit
	end

	# DELETE
	# Elimina un terapeuta
	def delete
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