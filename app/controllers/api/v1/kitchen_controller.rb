class Api::V1::KitchenController < ApplicationController
  before_action :authorize_request

  def index
    kitchens = Kitchen.joins([:tags, :user, :kitchen_address]).includes([:tags, :user, :kitchen_address])
    json_response({kitchens: kitchens.as_json(:include => [:tags, :kitchen_address, :user => {:except => [:password_digest, :confirm_token]}])}, 200)
  end

end
