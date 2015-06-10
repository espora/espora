# == Schema Information
#
# Table name: paternal_traits
#
#  id                     :integer          not null, primary key
#  from_mother            :boolean
#  patient_record_id      :integer
#  paternal_trait_type_id :integer
#  created_at             :datetime
#  updated_at             :datetime
#
class PaternalTrait < ActiveRecord::Base

	# Expediente de paciente
	belongs_to :patient_record

	# Tipo de rasgo paterno
	belongs_to :paternal_trait_type

end
