# frozen_string_literal: true

class AppointmentPolicy < ApplicationPolicy
  def show_appointment?
    doctor_owner? || patient_owner?
  end

  def index?
    user.present?
  end

  def create?
    user.patient?
  end

  def update?
    user.patient? && patient_owner?
  end

  def destroy?
    user.patient? && patient_owner?
  end

  private

  def doctor_owner?
    record.doctor_id == user.id
  end

  def patient_owner?
    record.patient_id == user.id
  end
end
