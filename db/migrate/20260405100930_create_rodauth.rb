# frozen_string_literal: true

class CreateRodauth < ActiveRecord::Migration[8.1]
  def change
    enable_extension "citext"

    create_table_accounts
    create_table_account_password_reset_keys
    create_table_account_verification_keys
    create_table_account_login_change_keys
    create_table_account_remember_keys
  end

  private

  def create_table_accounts
    create_table :accounts do |t|
      t.integer :status, null: false, default: 1
      t.citext :email, null: false
      t.check_constraint "email ~ '^[^,;@ \r\n]+@[^,@; \r\n]+\.[^,@; \r\n]+$'", name: "valid_email"
      t.index :email, unique: true, where: "status IN (1, 2)"
      t.string :password_hash
    end
  end

  def create_table_account_password_reset_keys
    # Used by the password reset feature
    create_table :account_password_reset_keys, id: false do |t|
      t.bigint :id, primary_key: true
      t.foreign_key :accounts, column: :id
      t.string :key, null: false
      t.datetime :deadline, null: false
      t.datetime :email_last_sent, null: false, default: -> { "CURRENT_TIMESTAMP" }
    end
  end

  def create_table_account_verification_keys
    # Used by the account verification feature
    create_table :account_verification_keys, id: false do |t|
      t.bigint :id, primary_key: true
      t.foreign_key :accounts, column: :id
      t.string :key, null: false
      t.datetime :requested_at, null: false, default: -> { "CURRENT_TIMESTAMP" }
      t.datetime :email_last_sent, null: false, default: -> { "CURRENT_TIMESTAMP" }
    end
  end

  def create_table_account_login_change_keys
    # Used by the verify login change feature
    create_table :account_login_change_keys, id: false do |t|
      t.bigint :id, primary_key: true
      t.foreign_key :accounts, column: :id
      t.string :key, null: false
      t.string :login, null: false
      t.datetime :deadline, null: false
    end
  end

  def create_table_account_remember_keys
    # Used by the remember me feature
    create_table :account_remember_keys, id: false do |t|
      t.bigint :id, primary_key: true
      t.foreign_key :accounts, column: :id
      t.string :key, null: false
      t.datetime :deadline, null: false
    end
  end
end
