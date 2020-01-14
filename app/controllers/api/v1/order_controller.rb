class Api::V1::OrderController < ApplicationController
    before_action :authorize_request
   
    def index
        user = User.find(@current_user_id)
        orders = user.orders.as_json(:include=>:order_foods)
        json_response({orders: orders}, 200)
    end

    def create
        user = User.find(@current_user_id)
        order_carts = user.customer_order_carts.where(:processed=>false)
        food_total_price = order_carts.joins(:food).sum(:price)
        order = Order.new(:user=> user, :status=> $ORDER_STATUS[:CREATED], :total_price=> food_total_price, :order_mode=> order_param[:order_mode], :order_foods_attributes => order_carts.map{|cart| {food: cart.food, price: cart.food.price, order_cart: cart}})
        if order.save
            json_response({order: order}, 200)
        else
            json_response(order.errors.full_messages, 401)
        end
    end

    def update
        user = User.find(@current_user_id)
        order = user.orders.find(params[:id])
        if order
            order.update_order_status(order_status_param[:status])
            json_response(order, 200)
        else
          json_response({}, 401, "Sorry!!! invalid code")
        end
    end

    def order_status_param
        params.required(:order).permit(:status)
    end

    def order_param
        params.required(:order).permit(:order_mode)
    end
end
