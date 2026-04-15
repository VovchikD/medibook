# frozen_string_literal: true

class CreateAppointments < ActiveRecord::Migration[8.1]
  def change
    create_table :appointments do |t|
      t.references :doctor,  foreign_key: { to_table: :accounts }
      t.references :patient, foreign_key: { to_table: :accounts }

      t.datetime :start_time, null: false
      t.datetime :end_time, null: false

      t.integer :status
      t.string :notes

      t.timestamps
    end
  end
end
