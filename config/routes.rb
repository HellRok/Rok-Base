RokBase::Engine.routes.draw do
  root to: 'sites#index'
  resources :sites do
    resources :uploads, shallow: true
    resources :site_aliases, shallow: true, only: [:new, :create, :destroy]
  end
end
