class Api::V1::KitchenController < ApplicationController
  before_action :authorize_request

  def index
    kitchens = Kitchen.joins([:tags, :user]).includes([:tags, :user])
    json_response({kitchens: kitchens.as_json(:include => [:tags, :user => {:except => [:password_digest, :confirm_token]}])}, 200)
  end

  protected

  def kitchen_param
    params.required(:kitchen).permit(:name, :title, :description, tags_attributes: [:name])
  end
end
