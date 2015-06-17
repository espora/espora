Espora::Application.routes.draw do

	# Sistema de login para terapeutas
	devise_for :therapists

	# Ruta raiz
	root "home#index"
	get	"/" => "home#index"

	################
	#  Terapeutas  #
	################

	# Perfil del terapeuta
	get "/therapists/profile/:id" => "therapists#profile", as: "therapist_profile"

	# Nuevo terapeuta
	get "/therapists/new_therapist" => "therapists#new", as: "new_therapist"

	# Crea terapeuta
	post "/therapists/create" => "therapists#create", as: "create_therapists"

	# Horarios
	get "/therapists/schedules/:id" => "therapists#schedules", as: "therapist_schedules"

	##################################################
	#  Solicitudes de ingreso Patient Request (LUE)  #
	##################################################

	# Consultar lue
	get "/therapists/lue" => "patient_requests#lue", as: "lue_index"

	# Nueva solicitud de pacientes
	get "/therapists/lue/new" => "patient_requests#new", as: "new_patient_request"

	# Crear solicitud paciente
	post "/therapists/lue/create" => "patient_requests#create", as: "patient_requests"

	# Editar solicitud
	get "/therapists/lue/edit/:id" => "patient_requests#edit", as: "edit_patient_request"

	# Salvar solicitud
	patch "/therapists/lue/create" => "patient_requests#update", as: "patient_request"

	# Editar solicitud paciente
	get "/therapists/lue/edit/:id" => "patient_requests#edit", as: "patient_request_edit"

	# Obtener los datos de horarios solicitados
	get "/therapists/lue/request_schedules/:id" => "patient_requests#schedules", as: "request_schedules"

	# Un terapeuta comienza a tender a un paciente (se crea su expediente)
	get "/therapists/lue/assign/:id" => "patient_requests#assign", as: "assign_patient"

	###############
	#  Pacientes  #
	###############

	# Marcar el paciente como no interesado
	get "/therapists/lue/mark_uninterested/:id" => "patients#mark_uninterested", as: "patient_mark_uninterested"

	# Marcar la solicitud como paciente contactado
	get "/therapists/lue/mark_contacted/:id" => "patients#mark_contacted", as: "patient_mark_contacted"

	###############################################
	#  Expedientes de pacientes (Patient Record)  #
	###############################################

	# Expedientes asignados al terapeuta
	get "/therapists/fosti" => "patient_records#fosti", as: "fosti_index"

	# Muestra el expediente
	get "/therapists/havad/:id" => "patient_records#havad", as: "havad_index"

	# Salvar el expediene de paciente
	patch "/therapists/havad/update/:id" => "patient_records#update", as: "patient_record"

	# Elige un expediente para trabajar
	get "/therapists/havad/open_record/:id" => "patient_records#open", as: "open_record"

	# Elige un expediente a trabajar
	get "/therapists/havad/close_record/:id" => "patient_records#close", as: "close_record"

	# Datos del paciente
	get "/therapists/havad/:id/patient" => "patient_records#patient", as: "patient_index"

	###########
	#  Citas  #
	###########

	# Ver citas
	get "/therapists/havad/:id/appointments" => "appointments#index", as: "appointments"

	# Crea una cita
	post "/therapists/havad/:id/appointment/create" => "appointments#create", as: "create_appointment"

	# Elige una cita
	get "/therapists/havad/:id/open_appointment/:appointment_id" => "appointments#open", as: "open_appointment"

	# Cierra una cita
	get "/therapists/havad/:id/close_appointment/:appointment_id" => "appointments#close", as: "close_appointment"	

	# Ve una cita
	get "/therapists/havad/:id/appointment/:appointment_id" => "appointments#show", as: "show_appointment"

	# Actualiza la informacion de una cita
	patch "/therapists/havad/appointment/update/:id" => "appointments#update", as: "appointment"

	###############################
	#  Egresos (Patient Dropout)  #
	###############################

	# Salvar una canalizacion
	post "/therapists/dropout/channelization" => "patient_dropouts#create_channelization", as: "patient_channelizations"

	# Dar de baja por interrupcion
	get "/therapists/dropout/interruption/:id" => "patient_dropouts#create_interruption", as: "patient_interruption"

	# Dar de baja por abandono
	get "/therapists/dropout/abandonment/:id" => "patient_dropouts#create_abandonment", as: "patient_abandonment"

	# Llenar egreso
	get "/therapists/dropout/fill_signout/:id" => "patient_dropouts#fill_signout", as: "patient_fill_signout"

end
