# frozen_string_literal: true

class StorageController < ApplicationController
  before_action :authenticate_user!

  def index
    @instances = Instance.where(user_id: current_user.id)
  end

  def file
    @instance = Instance.new()
    @instance.user_id = current_user.id
    @instance.files.attach(params[:file])
    @instance.save
  end

  def destroy
    @instance = Instance.find(params[:id])
    @instance.destroy
    redirect_to storage_index_path
  end
end
