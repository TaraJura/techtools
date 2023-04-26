# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :invoices
  resources :questions
  resources :isdoc, only: %i[index show]
  root 'questions#index'
end
