class ChangeTimeLogToFloat < ActiveRecord::Migration
  def change
    change_column :time_logs, :duration, :float
  end
end
