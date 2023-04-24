# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :cookie_user

  def cookie_user
    return if cookies[:current_user].present?

    cookies[:current_user] = {
      value: SecureRandom.uuid,
      expires: 8.hours.from_now
    }
  end
end
