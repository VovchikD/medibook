# frozen_string_literal: true

class AddProfileFieldsToAccounts < ActiveRecord::Migration[8.1]
  def change
    add_column :accounts, :fullname, :string
    add_column :accounts, :phone, :string
  end
end
