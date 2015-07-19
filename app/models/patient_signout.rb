class PatientSignout < ActiveRecord::Base

	# Nivel de ayuda (Que tanto te ayudo)
	belongs_to :aid_level_type

	# Condición (Como se siente)
	belongs_to :condition_type

	# Nivel de sugerencia (Que tanto sugieres espora)
	belongs_to :advise_level_type

	# Baja
	belongs_to :patient_dropout

	# Areas mejoradas
	has_many :improve_areas, :dependent => :delete_all
	
	# Areas mejoradas en formularios anidados
	accepts_nested_attributes_for :improve_areas, :allow_destroy => true

	# Devuelve las opciones de calificacion
	def self.select_rating

		# Creamos el arreglo
		options = Array.new

		# Iteramos
		10.times do | n |
			options << [(n + 1).to_s, (n + 1).to_s]
		end

		return options
	end

end
