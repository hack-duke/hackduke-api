class AddOrientationToPeople < ActiveRecord::Migration[5.0]
  def change
  	add_column :people, :orientation, :string
  end
end
