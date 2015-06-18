# == Schema Information
#
# Table name: patient_signouts
#
#  id                 :integer          not null, primary key
#  aid_level_id       :integer
#  condition_type_id  :integer
#  rating             :integer
#  advise_level_id    :integer
#  satisfactions      :text
#  claims             :text
#  observations       :text
#  patient_dropout_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#
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

end
