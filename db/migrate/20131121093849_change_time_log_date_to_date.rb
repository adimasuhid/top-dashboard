class ChangeTimeLogDateToDate < ActiveRecord::Migration
  def change
    change_column :time_logs, :date, :date
    rename_column :time_logs, :date, :session_date
  end
end
