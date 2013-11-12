class AddStufftoStudent < ActiveRecord::Migration
  def change
    add_column :students, :first_name, :string
    add_column :students, :last_name, :string
    add_column :students, :year_level, :integer
  end
end
