Rails.application.routes.draw do
	root "graphs#show"

	resources :graphs, only: :show
end
