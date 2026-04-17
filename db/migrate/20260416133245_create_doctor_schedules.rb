# frozen_string_literal: true

class CreateDoctorSchedules < ActiveRecord::Migration[8.1]
  def change
    create_table :doctor_schedules do |t|
      t.references :doctor, foreign_key: { to_table: :accounts }
      t.integer :day_of_week
      t.boolean :enabled, default: true
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
