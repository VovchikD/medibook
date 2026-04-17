# frozen_string_literal: true

class BaseController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate, unless: :auth_page?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_account
    rodauth.rails_account
  end
  helper_method :current_account

  inertia_share do
    {
      user: current_account,
      flash: { alert: flash[:alert] }
    }
  end

  private

  def authenticate
    return if rodauth.logged_in?

    redirect_to '/login'
  end

  def auth_page?
    controller_name == 'accounts'
  end

  def pundit_user
    current_account
  end

  private

  def user_not_authorized
    redirect_back fallback_location: root_path,
      alert: 'You are not authorized to perform this action.'
  end
end
