class DelivererDecisionMailer < ApplicationMailer
  def deliverer_decision(order)
    @order = order
    @order_content = @order.content.gsub(/\r\n|\r|\n/, '<br>').html_safe
    @order_note = @order.note.gsub(/\r\n|\r|\n/, '<br>').html_safe

    mail to: @order.customer.email, subject: '配達員が決定しました'
  end
end
