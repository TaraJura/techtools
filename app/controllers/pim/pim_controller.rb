# frozen_string_literal: true
module Pim
  class PimController < ApplicationController
    def binance
      render json: { message: 'Hello from PIM' }
    end
  end
end