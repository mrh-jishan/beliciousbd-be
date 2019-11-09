class Api::V1::OrderCartController < ApplicationController
    before_action :authorize_request

        # todo --- fix n+1 issue

        # as_json(except: [:password_digest, :confirm_token]
        def index
            user = @current_user
            order_carts = user.customer_order_carts.as_json(
                :include=>{
                    :customer=>{:except=>[:password_digest, :confirm_token]},
                    :chef=>{:except=>[:password_digest, :confirm_token]},
                    :food=>{:food=>:food}
                    })
            json_response({order_cart: order_carts}, 200)
        end     
end
