Espora::Application.routes.draw do

  get "patients/new"
  get "patients/create"
  get "patient_requests/new"
  get "therapists/show"
  devise_for :therapists

  # Ruta raiz
  root 'home#index'
  get  "/" => "home#index"

  # Terapeutas
  get "/therapist" => "therapists#show", as: "therapist_index"
  get "/therapists/new" => "therapists#new", as: "new_therapist"
  post "/therapists/create" => "therapists#create", as: "create_therapists"

  # Solicitudes de ingreso (LUE)

  # Crear solicitud paciente
  get "/patient_requests/new" => "patient_requests#new", as: "new_patient_request"
  post "/patient_requests/create" => "patient_requests#create", as: "create_patient_request"

  # Consultar lue
  #get "/lue" => "", as: "patient_requests#show", as: "show_lue"

  # Pacientes

end
