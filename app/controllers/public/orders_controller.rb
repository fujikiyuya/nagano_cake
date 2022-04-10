class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def comfirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    if @order.save
      cart_items.each do |cart_item|
        order_detile = OrderDetile.new
        order_detile.item_id = cart_item.item_id
        order_detile.order_id = @order.id
        order_detile.order_amount = cart_item.amount
        order_detile.order_price = cart_item.item.price
        order_detile.save
      end
      redirect_to complete_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end

  def index
  end

  def show
  end

  def complete
  end
end
