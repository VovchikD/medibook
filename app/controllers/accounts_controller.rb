# frozen_string_literal: true

class AccountsController < BaseController
  def login
    render inertia: 'accounts/Login'
  end

  def register
    render inertia: 'accounts/Register'
  end
end
