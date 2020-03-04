class AddStatusToRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :relationships, :status, :integer
  end
end
