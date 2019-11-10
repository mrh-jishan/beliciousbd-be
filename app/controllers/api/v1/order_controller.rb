class Api::V1::OrderController < ApplicationController
    before_action :authorize_request
   
    #<Order id: nil, user_id: nil, status: "created", total_price: nil, order_mode: nil, created_at: nil, updated_at: nil> 
    #<OrderFood id: nil, order_id: nil, food_id: nil, price: nil, created_at: nil, updated_at: nil>


    def index
        user = @current_user
        order = user.orders
        # order_carts = user.customer_order_carts.where(:processed=>false).as_json(
        #     :include=>{
        #         :customer=>{:except=>[:password_digest, :confirm_token]},
        #         :chef=>{:except=>[:password_digest, :confirm_token]},
        #         :food=>{:food=>:food}
        #         })
        json_response({order_cart: order}, 200)
    end

    def create
        user = @current_user
        order_carts = user.customer_order_carts.where(:processed=>false)
        food_total_price = order_carts.joins(:food).sum(:price)
        order = Order.new(:user=> user, :status=> 'created', :total_price=> food_total_price, :order_mode=>'Take-Away', :order_foods_attributes => order_carts.map{|cart| {food: cart.food, price: cart.food.price}})
        if order.save
            json_response({order: order}, 200)
        else
            json_response(order.errors.full_messages, 401)
        end
    end
end
