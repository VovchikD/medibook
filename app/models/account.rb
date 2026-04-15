# frozen_string_literal: true

class Account < ApplicationRecord
  include Rodauth::Rails.model

  enum :status, { unverified: 1, verified: 2, closed: 3 }
  enum :role,   { patient: 0, doctor: 1 }

  has_many :patient_appointments, class_name: 'Appointment', foreign_key: :patient_id
end
