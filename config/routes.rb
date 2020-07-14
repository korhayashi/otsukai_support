# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#          new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
#              user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
#      destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
#         new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#        edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#             user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                           PUT    /users/password(.:format)                                                                devise/passwords#update
#                           POST   /users/password(.:format)                                                                devise/passwords#create
#  cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
#     new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
#    edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
#         user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
#                           PUT    /users(.:format)                                                                         devise/registrations#update
#                           DELETE /users(.:format)                                                                         devise/registrations#destroy
#                           POST   /users(.:format)                                                                         devise/registrations#create
#     new_user_confirmation GET    /users/confirmation/new(.:format)                                                        devise/confirmations#new
#         user_confirmation GET    /users/confirmation(.:format)                                                            devise/confirmations#show
#                           POST   /users/confirmation(.:format)                                                            devise/confirmations#create
#                      root GET    /                                                                                        contents#index
#                      home GET    /home(.:format)                                                                          contents#home
#            history_orders GET    /orders/history(.:format)                                                                orders#history
#                    orders GET    /orders(.:format)                                                                        orders#index
#                           POST   /orders(.:format)                                                                        orders#create
#                 new_order GET    /orders/new(.:format)                                                                    orders#new
#                edit_order GET    /orders/:id/edit(.:format)                                                               orders#edit
#                     order PATCH  /orders/:id(.:format)                                                                    orders#update
#                           PUT    /orders/:id(.:format)                                                                    orders#update
#     conversation_messages GET    /conversations/:conversation_id/messages(.:format)                                       messages#index
#                           POST   /conversations/:conversation_id/messages(.:format)                                       messages#create
#  new_conversation_message GET    /conversations/:conversation_id/messages/new(.:format)                                   messages#new
# edit_conversation_message GET    /conversations/:conversation_id/messages/:id/edit(.:format)                              messages#edit
#      conversation_message GET    /conversations/:conversation_id/messages/:id(.:format)                                   messages#show
#                           PATCH  /conversations/:conversation_id/messages/:id(.:format)                                   messages#update
#                           PUT    /conversations/:conversation_id/messages/:id(.:format)                                   messages#update
#                           DELETE /conversations/:conversation_id/messages/:id(.:format)                                   messages#destroy
#             conversations GET    /conversations(.:format)                                                                 conversations#index
#                           POST   /conversations(.:format)                                                                 conversations#create
#          new_conversation GET    /conversations/new(.:format)                                                             conversations#new
#         edit_conversation GET    /conversations/:id/edit(.:format)                                                        conversations#edit
#              conversation GET    /conversations/:id(.:format)                                                             conversations#show
#                           PATCH  /conversations/:id(.:format)                                                             conversations#update
#                           PUT    /conversations/:id(.:format)                                                             conversations#update
#                           DELETE /conversations/:id(.:format)                                                             conversations#destroy
#         letter_opener_web        /letter_opener                                                                           LetterOpenerWeb::Engine
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
#
# Routes for LetterOpenerWeb::Engine:
# clear_letters DELETE /clear(.:format)                 letter_opener_web/letters#clear
# delete_letter DELETE /:id(.:format)                   letter_opener_web/letters#destroy
#       letters GET    /                                letter_opener_web/letters#index
#        letter GET    /:id(/:style)(.:format)          letter_opener_web/letters#show
#               GET    /:id/attachments/:file(.:format) letter_opener_web/letters#attachment

Rails.application.routes.draw do
  devise_for :users
  root 'contents#index'
  get '/home', to: 'contents#home'
  resources :orders, only: [:index, :new, :create, :edit, :update] do
    collection do
      get :history
    end
  end

  resources :conversations do
    resources :messages
  end

  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
