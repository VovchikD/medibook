# frozen_string_literal: true

class BaseController < ApplicationController
  before_action :authenticate, unless: :auth_page?

  def current_account
    rodauth.rails_account
  end
  helper_method :current_account

  inertia_share do
    { user: current_account }
  end

  private

  def authenticate
    return if rodauth.logged_in?

    redirect_to '/login'
  end

  def auth_page?
    controller_name == 'accounts'
  end
end
