class ContentsController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def home
  end

  def index
    @customer_orders0 = Order.where(customer_id: current_user.id).where(status: 0)
    @customer_orders1 = Order.where(customer_id: current_user.id).where(status: 1)
    @courier_orders = Order.where(courier_id: current_user.id).where(status: 1)
  end
end
