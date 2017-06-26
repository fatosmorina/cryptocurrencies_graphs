Rails.application.routes.draw do
	root "currencies#show", id: "bitcoin"

	resources :currencies, only: :show
end
