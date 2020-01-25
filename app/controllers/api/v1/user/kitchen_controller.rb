class Api::V1::User::KitchenController < ApplicationController
  before_action :authorize_request

  def create
    kitchen = User.find(@current_user_id).kitchens.new(kitchen_param)
    if kitchen.save
      json_response({:kitchen => kitchen.as_json(:include => [:tags, :kitchen_address])}, 200)
    else
      json_response(kitchen.errors.full_messages, 401, kitchen.errors.full_messages.first)
    end
  end

  def index
    kitchens = Kitchen.joins([:tags, :user, :kitchen_address]).where(:user_id => @current_user_id).includes([:tags, :user, :kitchen_address])
    json_response({kitchens: kitchens.as_json(:include => [:tags, :kitchen_address, :user => {:except => [:password_digest, :confirm_token]}])}, 200)
  end

  protected

  def kitchen_param
    params.required(:kitchen).permit(:name, :title, :description,
                                     [tags_attributes: [:name]],
                                     kitchen_address_attributes: [:address, :city, :state, :zip_code])
  end
end
