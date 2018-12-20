class AuthenticatedAdminConstraint
  def matches?(request)
    request.session['user_id'].present? && User.find(request.session['user_id']).role == 'role_admin'
  end
end

class AuthenticatedUserConstraint
  def matches?(request)
    request.session['user_id'].present? && User.find(request.session['user_id']).role != 'role_admin'
  end
end

Rails.application.routes.draw do
  constraints AuthenticatedAdminConstraint.new do
    root to: 'admin/users#index'
  end

  constraints AuthenticatedUserConstraint.new do
    root to: 'tasks#index'
  end

  root to: 'sessions#new'

  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users do
      patch 'change_role', on: :member
    end
  end
end
