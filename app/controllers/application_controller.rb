class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :my_items, only: [:edit, :update]

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:category, :family_name, :first_name, :postal_code, :address, :phone_number, :admin])

    devise_parameter_sanitizer.permit(:account_update, keys: [:category, :family_name, :first_name, :postal_code, :address, :phone_number, :admin, :icon, :icon_cache])
  end

  def not_authorized_from_customer
    if current_user.category == 'カスタマー'
      redirect_to home_path
    end
  end

  def not_authorized_from_courier
    if current_user.category == '配達員'
      redirect_to home_path
    end
  end

  def after_sign_in_path_for(resource)
    home_path
  end

  def my_items
    @customer_orders0 = Order.where(customer_id: current_user.id).where(status: 0)
    @customer_orders1 = Order.where(customer_id: current_user.id).where(status: 1)
    @courier_orders = Order.where(courier_id: current_user.id).where(status: 1)
    @now = DateTime.now
  end
end
