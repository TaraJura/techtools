# frozen_string_literal: true

require_relative '../lib/app_settings'

AppSettings.define do
  config.validate_keys = true

  required(:database).hash do
    required(:username).value(:string)
    required(:password).value(:string)
    required(:name).value(:string)
    optional(:socket).value(:string)
  end

  required(:smtp).hash do
    required(:address).value(:string)
    required(:port).value(:integer)
    optional(:user_name).value(:string)
    optional(:password).value(:string)
    optional(:openssl_verify_mode).value(:string)
    optional(:ca_file).value(:string)
  end
end
