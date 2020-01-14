class Api::V1::User::KitchenController < ApplicationController
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


  # todo --- fix n+1 issue
  def index
    #user = @current_user
    #json_response({user: user.as_json(except: [:password_digest, :confirm_token],
    #                                  :include => {:kitchens => {:include => :tags}})}, 200)

    kitchens = Kitchen.where(:users => [User.find(@current_user_id)]).includes(:tags).as_json(:include => [:tags])
    json_response({kitchens: kitchens}, 200)
  end

  protected

  def kitchen_param
    params.required(:kitchen).permit(:name, :title, :description, tags_attributes: [:name])
  end
end
