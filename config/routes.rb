Rails.application.routes.draw do

  resources :products
  resources :attachments, only: [:new, :create, :destroy, :show]
  resources :in_shopping_carts, only: [:create, :destroy]

  get 'emails/create'

  devise_for :users

  post "/emails/create", as: :create_email
  post "/pagar", to: "payments#create"
  get "/checkout", to: "payments#checkout"

  #tarjeta credito
  post "/payments/cards", to: "payments#process_card"

  #Carrito de compras -> carrito_path
  get "/carrito", to: 'shopping_carts#show'
  # para mandar a create de in_shopping_cart -> agregar_al_carrito_path
  get "/agregar/:product_id", to: "in_shopping_carts#create", as: :agregar_al_carrito
  # succed venta
  get "/ok", to: "welcome#payment_succed"


  # rutas para descarga de archivos
  get "/descargar/:id", to:"links#download"
  get "/descargar/:id/archivo/:attachment_id", to:"links#download_attachment", as: :download_attachment
  get "/invalid", to: "welcome#unregistered"

  authenticated :user do
    root 'welcome#index'
  end

  unauthenticated :user do
    devise_scope :user do
      root 'welcome#unregistered', as: :unregistered
    end
  end





  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
