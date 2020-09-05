# == Route Map
#
#                       Prefix Verb   URI Pattern                                                                              Controller#Action
#                  rails_admin        /admin                                                                                   RailsAdmin::Engine
#             new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
#                 user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
#         destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
#            new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#           edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#                user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                              PUT    /users/password(.:format)                                                                devise/passwords#update
#                              POST   /users/password(.:format)                                                                devise/passwords#create
#     cancel_user_registration GET    /users/cancel(.:format)                                                                  users/registrations#cancel
#        new_user_registration GET    /users/sign_up(.:format)                                                                 users/registrations#new
#       edit_user_registration GET    /users/edit(.:format)                                                                    users/registrations#edit
#            user_registration PATCH  /users(.:format)                                                                         users/registrations#update
#                              PUT    /users(.:format)                                                                         users/registrations#update
#                              DELETE /users(.:format)                                                                         users/registrations#destroy
#                              POST   /users(.:format)                                                                         users/registrations#create
#                      sign_in GET    /sign_in(.:format)                                                                       users/sessions#new
#                     sign_out GET    /sign_out(.:format)                                                                      users/sessions#destroy
# users_guest_customer_sign_in POST   /users/guest_customer_sign_in(.:format)                                                  users/sessions#guest_customer
#  users_guest_courier_sign_in POST   /users/guest_courier_sign_in(.:format)                                                   users/sessions#guest_courier
#                         root GET    /                                                                                        contents#index
#                         home GET    /home(.:format)                                                                          contents#home
#                       thanks GET    /thanks(.:format)                                                                        contents#thanks
#               history_orders GET    /orders/history(.:format)                                                                orders#history
#               confirm_orders POST   /orders/confirm(.:format)                                                                orders#confirm
#                       orders GET    /orders(.:format)                                                                        orders#index
#                              POST   /orders(.:format)                                                                        orders#create
#                    new_order GET    /orders/new(.:format)                                                                    orders#new
#                   edit_order GET    /orders/:id/edit(.:format)                                                               orders#edit
#                        order PATCH  /orders/:id(.:format)                                                                    orders#update
#                              PUT    /orders/:id(.:format)                                                                    orders#update
#        conversation_messages GET    /conversations/:conversation_id/messages(.:format)                                       messages#index
#                              POST   /conversations/:conversation_id/messages(.:format)                                       messages#create
#                conversations POST   /conversations(.:format)                                                                 conversations#create
#            letter_opener_web        /letter_opener                                                                           LetterOpenerWeb::Engine
#           rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#    rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#           rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#    update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#         rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
#
# Routes for RailsAdmin::Engine:
#   dashboard GET         /                                  rails_admin/main#dashboard
#       index GET|POST    /:model_name(.:format)             rails_admin/main#index
#         new GET|POST    /:model_name/new(.:format)         rails_admin/main#new
#      export GET|POST    /:model_name/export(.:format)      rails_admin/main#export
# bulk_delete POST|DELETE /:model_name/bulk_delete(.:format) rails_admin/main#bulk_delete
# bulk_action POST        /:model_name/bulk_action(.:format) rails_admin/main#bulk_action
#        show GET         /:model_name/:id(.:format)         rails_admin/main#show
#        edit GET|PUT     /:model_name/:id/edit(.:format)    rails_admin/main#edit
#      delete GET|DELETE  /:model_name/:id/delete(.:format)  rails_admin/main#delete
#
# Routes for LetterOpenerWeb::Engine:
# clear_letters DELETE /clear(.:format)                 letter_opener_web/letters#clear
# delete_letter DELETE /:id(.:format)                   letter_opener_web/letters#destroy
#       letters GET    /                                letter_opener_web/letters#index
#        letter GET    /:id(/:style)(.:format)          letter_opener_web/letters#show
#               GET    /:id/attachments/:file(.:format) letter_opener_web/letters#attachment

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessionts: 'users/sessions',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#destroy"
    post 'users/guest_customer_sign_in', to: 'users/sessions#guest_customer'
    post 'users/guest_courier_sign_in', to: 'users/sessions#guest_courier'
  end

  root 'contents#index'
  get '/home', to: 'contents#home'
  get '/thanks', to: 'contents#thanks'
  resources :orders, only: [:index, :new, :create, :edit, :update] do
    collection do
      get :history
      post :confirm
    end
  end

  resources :conversations, only: [:create] do
    resources :messages, only: [:index, :create]
  end

  # if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  # end
end
