class AddBranchToTherapist < ActiveRecord::Migration
  def change
    add_reference :therapists, :branch, index: true
  end
end
