RokBase::Engine.routes.draw do
  root to: 'sites#index'
  resources :sites do
    resources :uploads, shallow: true
  end
end
