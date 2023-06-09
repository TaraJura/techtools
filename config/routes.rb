# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :invoices
  resources :questions
  resources :isdoc, only: %i[index show]
  resources :storage, only: %i[index]
  resources :public_storage, only: %i[index]
  root 'questions#index'

  post 'storage/file', to: 'storage#file'
  post 'public_storage/file', to: 'public_storage#file'
  get '/download_example', to: 'isdoc#download_example', as: 'download_example'
end
