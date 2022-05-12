class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @cart_items = current_customer.cart_items.all
    if !@cart_items.present?
      redirect_to items_path
    end
  end

  def comfirm
    @cart_items = current_customer.cart_items.all
    @total = 0
    @order = Order.new
    @order.payment_method = params[:order][:payment_method]
    if params[:order][:address_option] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_option] == "2"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address_option] == "3"
      @address_new = current_customer.addresses.new
      if address_new.save
      else
        render :new
      end
    end
  end

  def create
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.item.with_tax_price
        order_detail.save
      end
      redirect_to complete_path
      @cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def complete
  end

  private

  def order_params
  params.require(:order).permit(:customer_id, :payment_method, :postal_code, :address, :name, :total_payment, :shipping_cost)
  end

end
