def find_item_by_name_in_collection(name, collection)
 # return matching hash
  index = 0 
  while index < collection.length do 
    if  collection[index][:item] == name
      return collection[index]
    end
    index += 1 
  end
  
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  newCart = []
  index = 0 
   while index < cart.length do 
     
     name = cart[index][:item]
     newCart_item =  find_item_by_name_in_collection(name,newCart)
     if newCart_item 
       newCart_item[:count] += 1
       
     else
        newCart_item = cart[index]
        newCart_item[:count] = 1
        #{
         # :item => name,
          #:price => cart[index][:price],
          #:clearance => cart[index][:clearance],
          #:count => 1
        #}
        newCart << newCart_item
      end
    index += 1 
    end
    newCart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  index = 0
  while index < coupons.length do
  name = coupons[index][:item]
  item_has_coupon = find_item_by_name_in_collection(name, cart)
  coupon = coupons[index]
  if item_has_coupon && item_has_coupon[:count] >= coupon[:num]
    item_has_coupon[:count] -= coupon[:num]
    #coupon hash
    item_coupon_hash = {
      :item => "#{item_has_coupon[:item]} W/COUPON",
      :price => coupon[:cost] / coupon[:num],
      :clearance => item_has_coupon[:clearance],
      :count => coupon[:num]
    }
    cart << item_coupon_hash
  end
  index +=1 
  end 
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  # 20% off 
  index = 0 
  while index < cart.length do
    
  if cart[index][:clearance] 
    cart[index][:price] = (cart[index][:price] * 0.8).round(2)
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
  newcart = consolidate_cart(cart)
  newcart = apply_coupons(newcart,coupons)
  newcart = apply_clearance(newcart)
  index = 0 
  while index < newcart.length do 
    total += newcart[index][:price] * newcart[index][:count]
    index += 1 
  end
  
  if total > 100
    total *= 0.9
  end 
  total
end
