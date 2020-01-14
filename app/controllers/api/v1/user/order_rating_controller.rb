class Api::V1::User::OrderRatingController < ApplicationController
  before_action :authorize_request

  def create
    user = User.find(@current_user_id)
    order = user.orders.find(params[:order_id])
    if order
      order_rating = OrderRating.new(order_rating_param)
      order_rating.order = order
      order_rating.user = user
      if order_rating.save
        json_response({order_rating: order_rating}, 200)
      else
        json_response(order_rating.errors.full_messages, 200)
      end
    else
      json_response(order.errors.full_messages, 401)
    end
  end

  def order_rating_param
    params.required(:order_rating).permit(:rating, :comment)
  end
end
