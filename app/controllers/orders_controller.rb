class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update]

  def index
    if params[:sort_pass]
      @orders =
      if params[:sort] == 'created_at'
        Order.where(status: 0).order(created_at: :desc)
      elsif params[:sort] == 'deadline'
        Order.where(status: 0).order(deadline: :asc)
      end

      render :index
    end
    @orders = Order.where(status: 0).where('deadline > ?', DateTime.now).order(created_at: :desc)
  end

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @order_content = @order.content.gsub(/\r\n|\r|\n/, '<br>').html_safe
    @order_note = @order.note.gsub(/\r\n|\r|\n/, '<br>').html_safe
    render :new if @order.invalid?
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_user.id
    if params[:back]
      render :new
    else
      if @order.save
        redirect_to root_path
      else
        render :new
      end
    end
  end

  def edit
    @order = Order.find(params[:id])
    @order_content = @order.content.gsub(/\r\n|\r|\n/, '<br>').html_safe
    @order_note = @order.note.gsub(/\r\n|\r|\n/, '<br>').html_safe
  end

  def update
    @order.courier_id = current_user.id
    if @order.update(order_params)
      redirect_to root_path
    else
      render :edit
    end
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
    params.require(:order).permit(:content, :note, :status, :deadline, :completed_date, :customer_id, :courier_id)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
