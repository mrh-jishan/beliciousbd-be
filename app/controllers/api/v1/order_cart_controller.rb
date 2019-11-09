class Api::V1::OrderCartController < ApplicationController
    before_action :authorize_request

    def create
        food = Food.find(order_cart_param[:food_id])
        user = @current_user
        order_cart = OrderCart.new(:food=> food, :customer=>user, :chef=> food.kitchen.user)

        if order_cart.save 
            json_response({:order_cart=> order_cart}, 200)
        else
            json_response(food.errors.full_messages, 401)
        end
    end


    # todo --- fix n+1 issue
    def index
        user = @current_user
        order_carts = user.customer_order_carts.where(:processed=>false).as_json(
            :include=>{
                :customer=>{:except=>[:password_digest, :confirm_token]},
                :chef=>{:except=>[:password_digest, :confirm_token]},
                :food=>{:food=>:food}
                })
        json_response({order_cart: order_carts}, 200)
    end    
    
    def order_cart_param
        params.required(:order_cart).permit(:food_id)
    end
end
