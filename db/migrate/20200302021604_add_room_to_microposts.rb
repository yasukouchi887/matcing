class AddRoomToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :room, :integer
  end
end
