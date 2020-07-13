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
  end

  def edit
    @order = Order.find(params[:id])
    @order_content = @order.content.gsub(/\r\n|\r|\n/, '<br>').html_safe
    @order_customer = User.find(@order.customer_id)
    @order_courier = User.find(@order.courier_id) if @order.courier_id.present?
  end

  def update

  end

  def history
    @orders =
    if current_user.category == 'カスタマー'
      Order.where(customer_id: current_user.id).where(status: 2).order(created_at: :desc)
    elsif current_user.category == '配達員'
      Order.where(courier_id: current_user.id).where(status: 2).order(created_at: :desc)
    end

  end

  private

  def order_params
    params.require(:order).permit(:content, :note, :status, :deadline, :customer_id, :courier_id)
  end
end
