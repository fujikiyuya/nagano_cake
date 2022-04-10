class CartItem < ApplicationRecord

  def subtotal
    item.with_tax_price * amount
  end
  
  belongs_to :customer
  belongs_to :item

end
