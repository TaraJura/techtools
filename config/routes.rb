# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :invoices
  root 'welcome#index'
  get 'isdoc/:id', to: 'isdoc#show', as: 'isdoc'
end
