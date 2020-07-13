class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_user.id
    if @order.save
      redirect_to root_path
    else
      render :new
    end
    binding.irb
  end

  private

  def order_params
    params.require(:order).permit(:content, :note, :status, :deadline, :customer_id, :courier_id)
  end
end
