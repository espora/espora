class RemoveReasonsFromPatientRequests < ActiveRecord::Migration
  def change
    remove_column :patient_requests, :reasons, :text
  end
end
