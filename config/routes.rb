# frozen_string_literal: true

Rails.application.routes.draw do
  resources :invoices
  root 'welcome#index'
  get 'isdoc/:id', to: 'isdoc#show', as: 'isdoc'
end
