# frozen_string_literal: true

Rails.application.routes.draw do
  resources :invoices
  root 'welcome#index'
end
