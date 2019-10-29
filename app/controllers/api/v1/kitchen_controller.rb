class Api::V1::KitchenController < ApplicationController
    before_action :authorize_request
    
    def create
        kitchen = Kitchen.new(kitchen_param)

        kitchen.user = @current_user
        if kitchen.save
            json_response({:kitchen=>kitchen.as_json(:include=>:tags)}, 200)
        else
            json_response(kitchen.errors.full_messages, 401)
        end
    end

    def index
        user = @current_user
        json_response({user: user.as_json(include: {kitchens: {include: [:tags]}})}, 200)
    end


    protected
    
    def kitchen_param
        params.required(:kitchen).permit(:name, :title, :description, tags_attributes: [ :name ])
    end
end