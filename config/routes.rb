# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :invoices
  resources :questions
  resources :isdoc, only: %i[index show]
  resources :storage, only: %i[index destroy]
  root 'questions#index'

  post 'storage/file', to: 'storage#file'
  get '/download_example', to: 'isdoc#download_example', as: 'download_example'
end
