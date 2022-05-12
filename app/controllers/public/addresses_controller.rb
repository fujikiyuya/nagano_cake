class Public::AddressesController < ApplicationController
  def index
    @customer = current_customer
    @address = Address.new
    @addresses = Address.all
    @address.customer_id = current_customer.id
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to addresses_path
  end


  def edit
    @address = Address.find(params[:id])
    unless @address.customer_id == current_customer.id
      redirect_to address_path(current_customer.id)
    end
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

end
