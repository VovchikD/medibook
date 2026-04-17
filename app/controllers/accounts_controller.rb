# frozen_string_literal: true

class AccountsController < BaseController
  def login
    render inertia: 'accounts/Login'
  end

  def register
    render inertia: 'accounts/Register'
  end

  def show
    render inertia: 'accounts/Profile', props: AccountPresenter.new(current_account).as_json(:id)
  end
end
