class CreateTimeLogs < ActiveRecord::Migration
  def change
    create_table :time_logs do |t|
      t.integer :student_id
      t.datetime :date
      t.integer :duration
      t.text :notes
      t.integer :user_id

      t.timestamps
    end
  end
end
