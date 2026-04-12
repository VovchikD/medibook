# frozen_string_literal: true

require 'sequel/core'

class RodauthMain < Rodauth::Rails::Auth
  configure do
    enable :create_account, :login, :logout, :remember, :reset_password,
           :change_password, :change_login, :close_account, :json

    prefix '/auth'
    db Sequel.postgres(extensions: :activerecord_connection, keep_reference: false)
    convert_token_id_to_integer? { Account.columns_hash['id'].type == :integer }
    rails_controller { AccountsController }
    title_instance_variable :@page_title

    account_status_column :status
    account_password_hash_column :password_hash

    login_param 'email'
    require_login_confirmation? false
    password_param 'password'
    require_password_confirmation? false

    password_minimum_length 8
    password_maximum_bytes 72

    after_login { remember_login }

    json_response_error_key 'error'
    json_response_success_key 'message'

    logout_redirect '/login'
    reset_password_redirect { login_path }

    before_create_account do
      account[:fullname] = param('fullname')
      account[:phone] = param('phone')
    end
  end
end
