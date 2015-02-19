Espora::Application.routes.draw do

  devise_for :therapists

  # Ruta raiz
  root "home#index"
  get  "/" => "home#index"

  # Terapeutas
  get "/therapists/profile/:id" => "therapists#profile", as: "therapist_profile"

  # Crear terapeutas
  get "/therapists/new_therapist" => "therapists#new", as: "new_therapist"
  post "/therapists/create" => "therapists#create", as: "create_therapists"

  # Solicitudes de ingreso (LUE)

  # Consultar lue
  get "/therapists/lue" => "patient_requests#lue", as: "lue_index"
  post "/patient_requests/lue/search" => "patient_requests#search", as: "lue_search"
  #post "/lue" => "patient_requests#lue", as: "lue"

  # Crear solicitud paciente
  get "/therapists/lue/new" => "patient_requests#new", as: "new_patient_request"
  post "/patient_requests/create" => "patient_requests#create", as: "create_patient_request"

  # Pacientes

end
