# frozen_string_literal: true

class PublicStorageController < ApplicationController
  def index
    @instances = Instance.where(public: true)
  end

  def file
    @instance = Instance.new()
    @instance.public = true
    @instance.user_id = current_user.id
    @instance.files.attach(params[:file])
    @instance.save
  end
end
