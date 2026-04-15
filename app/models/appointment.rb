# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :doctor,  class_name: 'Account'
  belongs_to :patient, class_name: 'Account'
end
