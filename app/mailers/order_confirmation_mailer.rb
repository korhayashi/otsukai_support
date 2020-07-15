class OrderConfirmationMailer < ApplicationMailer
  def order_confirmation(order)
    @order = order
    @order_content = @order.content.gsub(/\r\n|\r|\n/, '<br>').html_safe
    @order_note = @order.note.gsub(/\r\n|\r|\n/, '<br>').html_safe
    
    mail to: @order.customer.email, subject: '買い物依頼を受け付けました'
  end
end
