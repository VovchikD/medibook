# frozen_string_literal: true

class AccountPolicy < ApplicationPolicy
  def bulk_update?
    doctor_owner?
  end

  private

  def doctor_owner?
    user.doctor? && record.id == user.id
  end
end
