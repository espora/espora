Espora::Application.routes.draw do

  get "patient_records/havad"
  devise_for :therapists

  # Ruta raiz
  root "home#index"
  get  "/" => "home#index"

  # Terapeutas
  get "/therapists/profile/:id" => "therapists#profile", as: "therapist_profile"

  # Crear terapeutas
  get "/therapists/new_therapist" => "therapists#new", as: "new_therapist"
  post "/therapists/create" => "therapists#create", as: "create_therapists"

  # Solicitudes de ingreso Patient Request (LUE)

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
  delete "/therapists/lue/delete/:id" => "patient_requests#delete", as: "patient_request_delete"

  # Marcar la solicitud como contactado
  post "/therapists/lue/mark_contact/:id" => "patients#mark_contact", as: "patient_mark_contact"

  # Expedientes de pacientes (Patient Record)
  get "/therapists/havad" => "patient_records#havad", as: "havad_index"

end
