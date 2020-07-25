class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update]
  before_action :not_authorized_from_courier, only: [:new, :confirm, :create]
  before_action :not_authorized_from_customer, only: [:index, :update]
  before_action :my_items

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
        OrderConfirmationMailer.order_confirmation(@order).deliver
        redirect_to home_path, notice: '買い物依頼ありがとうございます！配達員が見つかるのをお待ちください。'
      else
        render :new
      end
    end
  end

  def edit
    @order = Order.find(params[:id])

    @order_content = @order.content.gsub(/\r\n|\r|\n/, '<br>').html_safe
    @order_note = @order.note.gsub(/\r\n|\r|\n/, '<br>').html_safe
    if current_user.category == 'カスタマー'
      if current_user.id != @order.customer_id
        redirect_to home_path
      end
    elsif current_user.category == '配達員'
      if @order.status == '配達員決定' || @order.status == '配達完了'
        if current_user.id != @order.courier_id
          redirect_to home_path
        end
      end
    end
  end

  def update
    @order.courier_id = current_user.id
    if @order.update(order_params)
      if params[:commit] == '依頼受託'
        DelivererDecisionMailer.deliverer_decision(@order).deliver
        flash[:notice] = '依頼を受託しました。買い物に向かいましょう！'
      else
        flash[:notice] = '配達完了を報告しました。お疲れさまでした！'
      end
      redirect_to home_path
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

  def my_items
    @customer_orders0 = Order.where(customer_id: current_user.id).where(status: 0)
    @customer_orders1 = Order.where(customer_id: current_user.id).where(status: 1)
    @courier_orders = Order.where(courier_id: current_user.id).where(status: 1)
    @now = DateTime.now
  end
end
