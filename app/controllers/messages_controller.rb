class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

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
      if @message.save
        redirect_to conversation_messages_path(@conversation)
      else
        render 'index'
      end
    else
      redirect_to home_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
