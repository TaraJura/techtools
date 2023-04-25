# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :cookie_user
  # before_action :authenticate_user!

  def cookie_user
    return if cookies[:current_user].present?

    cookies[:current_user] = {
      value: SecureRandom.uuid,
      expires: 8.hours.from_now
    }
  end
end
