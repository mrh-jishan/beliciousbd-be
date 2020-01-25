class Api::V1::User::KitchenController < ApplicationController
  before_action :authorize_request

  def create
    user = User.find(@current_user_id)
    kitchen = user.kitchens.new(kitchen_param)
    if kitchen.save
      json_response({:kitchen => kitchen.as_json(:include => [:tags])}, 200)
    else
      json_response(kitchen.errors.full_messages, 401, kitchen.errors.full_messages.first)
    end
  end

  def index
    kitchens = Kitchen.joins([:tags, :user]).where(:user_id => @current_user_id).includes([:tags, :user])
    json_response({kitchens: kitchens.as_json(:include => [:tags, :user => {:except => [:password_digest, :confirm_token]}])}, 200)
  end

  protected

  def kitchen_param
    params.required(:kitchen).permit(:name, :title, :description, tags_attributes: [:name])
  end
end
