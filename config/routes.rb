Espora::Application.routes.draw do

  get "patient_records/havad"
  devise_for :therapists

  # Ruta raiz
  root "home#index"
  get  "/" => "home#index"

  ##### Terapeutas
  get "/therapists/profile/:id" => "therapists#profile", as: "therapist_profile"

  # Crear terapeutas
  get "/therapists/new_therapist" => "therapists#new", as: "new_therapist"
  post "/therapists/create" => "therapists#create", as: "create_therapists"

  ##### Solicitudes de ingreso Patient Request (LUE)

  # Consultar lue
  get "/therapists/lue" => "patient_requests#lue", as: "lue_index"

  # Crear solicitud paciente
  get "/therapists/lue/new" => "patient_requests#new", as: "new_patient_request"
  post "/therapists/lue/create" => "patient_requests#create", as: "patient_requests"

  # Editar y salvar
  get "/therapists/lue/edit/:id" => "patient_requests#edit", as: "edit_patient_request"
  patch "/therapists/lue/create" => "patient_requests#update", as: "patient_request"

  # Editar solicitud paciente
  get "/therapists/lue/edit/:id" => "patient_requests#edit", as: "patient_request_edit"

  # Eliminar solicitud paciente
  get "/therapists/lue/mark_uninterested/:id" => "patients#mark_uninterested", as: "patient_mark_uninterested"

  # Marcar la solicitud como paciente contactado
  get "/therapists/lue/mark_contacted/:id" => "patients#mark_contacted", as: "patient_mark_contacted"

  # Un terapeuta comienza a tender a un paciente (se crea su expediente)
  get "/therapists/lue/assign/:id" => "patient_requests#assign", as: "assign_patient"

  ##### Expedientes de pacientes (Patient Record)

  # Index de expedientes de paciente (FOSTI / HAVAD)
  get "/therapists/havad/" => "patient_records#havad", as: "havad_index"

  # Salvar el expediene de paciente
  patch "/therapists/lue/update" => "patient_records#update", as: "patient_record"

  # Elige el expediente con el que se va a trabajar
  get "/therapists/havad/choose_record/:id" => "patient_records#choose", as: "choose_record"
  get "/therapists/havad/close_record" => "patient_records#close", as: "close_record"

  # HAVAD
  get "/therapists/havad"

end
