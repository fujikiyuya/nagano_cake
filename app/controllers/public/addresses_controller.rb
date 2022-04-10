class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @address = Address.new(address_params)
    @address.save
    redirect_to addresses_path
    @addresses = Address.all
  end

  def edit
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
  end
end
