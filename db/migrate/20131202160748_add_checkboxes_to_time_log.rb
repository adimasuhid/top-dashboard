class AddCheckboxesToTimeLog < ActiveRecord::Migration
  def change
    add_column :time_logs, :parent_informed, :boolean, default: false
    add_column :time_logs, :parent_paid, :boolean, default: false
    add_column :time_logs, :tutor_paid, :boolean, default: false
  end
end
