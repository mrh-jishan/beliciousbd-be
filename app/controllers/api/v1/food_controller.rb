class Api::V1::FoodController < ApplicationController
    before_action :authorize_request
    before_action :set_kitchen, only: [:create, :index]

    def create
        food = Food.new(food_param)
        food.kitchen = @kitchen
        
        if food.save 
            json_response({:food=>food.as_json(:include=>:ingredients)}, 200)
        else
            json_response(food.errors.full_messages, 401)
        end
    end


    # todo --- fix n+1 issue
    def index
        kitchen = @kitchen
        json_response({kitchen: kitchen.as_json(:include => {:foods => {:include => :ingredients}})}, 200)
    end


    protected

    def set_kitchen
        @kitchen = Kitchen.find(params[:kitchen_id])
    end
    
    def food_param
        params.required(:food).permit(:name, :category, :description, :reciepe, ingredients_attributes: [ :name ])
    end

end
