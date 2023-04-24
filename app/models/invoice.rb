# frozen_string_literal: true

class Invoice < ApplicationRecord
  has_one_attached :file
end
