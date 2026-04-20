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
      user: current_account
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
    respond_to do |format|
      format.json { render json: { error: 'You are not authorized to perform this action.' }, status: :forbidden }
    end
  end
end
