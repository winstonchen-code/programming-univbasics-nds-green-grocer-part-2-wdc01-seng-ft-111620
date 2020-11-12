require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
   index = 0
    coupons_index = 0

  while coupons_index < coupons.size do
    current_coupon = coupons[coupons_index]
    applicable_for_discount = find_item_by_name_in_collection( current_coupon[:item], cart )
      if ( applicable_for_discount[:count] / current_coupon[:num] >= 1 )
        cart.push( {:item => "#{current_coupon[:item]} W/COUPON",
                    :price => (current_coupon[:cost] / current_coupon[:num]).round(2),
                    :clearance => applicable_for_discount[:clearance],
                    :count => applicable_for_discount[:count] - ( applicable_for_discount[:count] % current_coupon[:num])})

        applicable_for_discount[:count] %= current_coupon[:num]
      end
    coupons_index += 1
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
    index = 0
  while index < cart.length do
    item = cart[index]
    if item[:clearance]
      discounted_price = ((1 - CLEARANCE_DISCOUNT) * item[:price]).round(2)
        item[:price] = discounted_price
    end
    index += 1
  end

  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
    total = 0
  index = 0

  c_cart = consolidate_cart(cart)
  apply_coupons(c_cart, coupons)
  apply_clearance(c_cart)

  while index < c_cart.length do
    total += items_total_cost(c_cart[index])
    index += 1
  end

  total >= 100 ? total * (1.0 - VOLUME_DISCOUNT) : total
end

def items_total_cost(index)
  index[:count] * index[:price]
end
