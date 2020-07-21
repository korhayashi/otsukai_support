class ContentsController < ApplicationController
  before_action :authenticate_user!, only: [:home]

  def home
    @customer_orders0 = Order.where(customer_id: current_user.id).where(status: 0)
    @customer_orders1 = Order.where(customer_id: current_user.id).where(status: 1)
    @courier_orders = Order.where(courier_id: current_user.id).where(status: 1)
  end

  def index
    redirect_to home_path if user_signed_in?
  end
end
