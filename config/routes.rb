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
  post "/patient_requests/create" => "patient_requests#create", as: "create_patient_request"

  # Expedientes de pacientes (Patient Record)
  get "/therapists/havad" => "patient_records#havad", as: "havad_index"

  # HAVAD
  get "/therapists/havad"

end
