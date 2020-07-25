class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  before_action :my_items

  def index
    if current_user.id == @conversation.sender_id || current_user.id == @conversation.recipient_id
      @messages = @conversation.messages.order(:created_at)
      if @messages.last
        @messages.where.not(user_id: current_user.id).update_all(read: true)
      end
      if params[:m]
        @over_ten = false
      elsif @messages.length > 10
        @over_ten = true
        @messages = @messages.last(10)
      end
      @message = @conversation.messages.build
    else
      redirect_to home_path
    end
  end

  def create
    if current_user.id == @conversation.sender_id || current_user.id == @conversation.recipient_id
      @message = @conversation.messages.build(message_params)
      respond_to do |format|
        if @message.save
          format.js { render :index }
        else
          format.html { render 'index' }
        end
      end
    else
      redirect_to home_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end

  def my_items
    @customer_orders0 = Order.where(customer_id: current_user.id).where(status: 0)
    @customer_orders1 = Order.where(customer_id: current_user.id).where(status: 1)
    @courier_orders = Order.where(courier_id: current_user.id).where(status: 1)
    @now = DateTime.now
  end
end
