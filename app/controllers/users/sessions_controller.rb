# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def guest_customer
    user = User.customer
    sign_in user
    redirect_to home_path, notice: "カスタマーテストユーザーでログインしました！"
  end

  def guest_courier
    user = User.courier
    sign_in user
    redirect_to home_path, notice: "カスタマーテストユーザーでログインしました！"
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
