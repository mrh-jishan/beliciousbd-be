class Api::V1::UserController < ApplicationController
    before_action :authorize_request, :only => [:index]

    def create
        user = User.new(user_param)
        if user.save
            json_response({:user=>user.as_json(except: [:password_digest, :confirm_token])}, 200)
        else
            json_response(user.errors.full_messages, 401)
        end
    end

    def index
       json_response({:user=> @current_user.as_json(except: [:password_digest, :confirm_token])}, 200)
    end

    protected

    def user_param
        params.required(:user).permit(:first_name, :last_name, :email,:password, :gender, :role).delete_if do |key, val|
            key == 'role' && val == 'admin'
        end
    end
end
