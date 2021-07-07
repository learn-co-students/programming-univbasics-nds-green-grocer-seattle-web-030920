require'pry'

def find_item_by_name_in_collection(name, collection)
  n=nil
  i=0
  while i< collection.length
 n=collection[i] if collection[i][:item]== name
 i+=1
end
n
end

def consolidate_cart(cart)
  newcart=[]
  i=0
  while i<cart.length
  if !find_item_by_name_in_collection(cart[i][:item], newcart)
    newcart<< cart[i]
    newcart[-1][:count]=1
  else
    x=find_index_number(newcart, cart[i][:item])
    newcart[x][:count]+=1
  end
  i+=1
end
  newcart
end

def find_index_number(array, item)
  n=nil
  i=0
  while i<array.length
  n=i if array[i][:item]==item
  i+=1
end
n
end

def apply_coupons(cart, coupons)
  i=0
  newc=[]
  while i<cart.length
    if find_index_number(coupons, cart[i][:item])
       x= find_index_number(coupons, cart[i][:item])
       p={}
       p[:item]=cart[i][:item]
       p[:count]=cart[i][:count]
       p[:price]=cart[i][:price]
       p[:clearance]=cart[i][:clearance]
       newc<< p
       if newc[-1][:count] >= coupons[x][:num]
          newc[-1][:item]+= " W/COUPON"
          newc[-1][:price]=coupons[x][:cost]/ coupons[x][:num]
          newc[-1][:count]=coupons[x][:num]
          
          newc<< cart[i]
          cart[i][:count]=cart[i][:count]-coupons[x][:num]
        end
        
    else
       newc<< cart[i]
    end
    i+=1
  end
  newc
end

def apply_clearance(cart)
  i=0
  while i< cart.length
  cart[i][:price]=cart[i][:price]*0.8.round(2) if cart[i][:clearance]
  i+=1
end
cart
end

def checkout(cart, coupons)
  cart=consolidate_cart(cart)
  cart=apply_coupons(cart, coupons)
  cart=apply_clearance(cart)
  total=total_cart(cart)
end

def total_cart(cart)
  i=0
  total=0
  while i<cart.length
  total+=cart[i][:price]*cart[i][:count]
  i+=1
end
total=total*0.9 if total>100.0
total.round(2)
end