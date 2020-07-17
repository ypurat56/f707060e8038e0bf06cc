Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post "/phones" => "phones#phone_get"

  post "/phones/:number" => "phones#phone_custom"

  get "/phones" => "phones#show"

end
