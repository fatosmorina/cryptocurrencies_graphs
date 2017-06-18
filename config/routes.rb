Rails.application.routes.draw do
	root "currencies#show"

	resources :currencies, only: :show
end
