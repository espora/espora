class PatientRecord < ActiveRecord::Base

	# Paciente al que pertenece el expediente
	belongs_to :patient

	# Terapeuta que atiende el expediente
	belongs_to :therapist

	# Clasificacion internacional de enfermedades, decima version
	belongs_to :cie10_type

	# Estructura clinica
	belongs_to :clinical_structure_type

	# Citas
	has_many :appointments, :dependent => :destroy

	# Rasgos de los padres
	has_many :paternal_traits, :dependent => :destroy

	# Mecanismos
	has_and_belongs_to_many :mechanism_types

	# Situaciones y experiencias
	has_and_belongs_to_many :experience_types

end
