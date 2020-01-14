class Api::V1::FoodController < ApplicationController
  before_action :authorize_request
  before_action :set_kitchen, only: [:create]

  def create
    food = Food.new(food_param)
    food.kitchen = @kitchen

    if food.save
      json_response({:food => food.as_json(:include => :ingredients)}, 200)
    else
      json_response(food.errors.full_messages, 401)
    end
  end

  def index
    foods = Food.where(kitchen_id: kitchen_id).joins(:kitchen).includes([:ingredients, :kitchen])
    json_response({foods: foods.as_json(:include => [:ingredients, :kitchen])})
  end


  protected

  def set_kitchen
    @kitchen = Kitchen.find(kitchen_id)
  end

  def kitchen_id
    params[:kitchen_id]
  end

  def food_param
    params.required(:food).permit(:name, :category, :price, :description, :reciepe, ingredients_attributes: [:name])
  end

end
