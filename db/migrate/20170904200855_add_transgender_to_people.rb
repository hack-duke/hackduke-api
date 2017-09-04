class AddTransgenderToPeople < ActiveRecord::Migration[5.0]
  def change
  	add_column :people, :transgender, :string
  end
end
