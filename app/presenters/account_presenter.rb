# frozen_string_literal: true

class AccountPresenter
  def initialize(user)
    @user = user
  end

  def id
    @user.id
  end

  def isDoctor
    @user.doctor?
  end

  def as_json(*fields)
    fields.index_with { |field| public_send(field) }
  end
end
