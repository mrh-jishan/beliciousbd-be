class Api::V1::KitchenController < ApplicationController
  before_action :authorize_request

  def create
    kitchen = Kitchen.new(kitchen_param)
    kitchen.user = User.find(@current_user_id)
    if kitchen.save
      json_response({:kitchen => kitchen.as_json(:include => :tags)}, 200)
    else
      json_response(kitchen.errors.full_messages, 401)
    end
  end

  def index
    kitchens = Kitchen.joins([:tags, :user]).includes([:tags, :user])
    json_response({kitchens: kitchens.as_json(:include => [:tags, :user => {:except => [:password_digest, :confirm_token]}])}, 200)
  end

  protected

  def kitchen_param
    params.required(:kitchen).permit(:name, :title, :description, tags_attributes: [:name])
  end
end
