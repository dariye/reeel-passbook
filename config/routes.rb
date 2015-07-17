require 'api_constraints'

Rails.application.routes.draw do
  mount SabisuRails::Engine => "/sabisu_rails"
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :only => [:index, :show, :create, :update, :destroy]
      resources :screenings, :only => [:index, :show, :create, :update, :destroy]
      resources :passes, :only => [:index, :show, :create, :update, :destroy]
    end
  end

end
