class RemoveStatusFromPublications < ActiveRecord::Migration
  def change
    remove_column :publications, :status
    add_column :publications, :approved_at, :datetime
  end
end
