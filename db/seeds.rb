# frozen_string_literal: true

require 'faker'

10.times do |i|
  account = Account.find_or_initialize_by(email: "patient#{i + 1}@medibook.com")
  account.fullname = Faker::Name.name
  account.phone = Faker::PhoneNumber.cell_phone_in_e164
  account.role = :patient
  account.status = :verified
  account.password = 'password123'
  account.save!
end

5.times do |i|
  doctor = Account.find_or_initialize_by(email: "doctor#{i + 1}@medibook.com")
  doctor.fullname = Faker::Name.name
  doctor.phone = Faker::PhoneNumber.cell_phone_in_e164
  doctor.role = :doctor
  doctor.status = :verified
  doctor.password = 'password123'
  doctor.save!
end
