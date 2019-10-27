class Api::V1::UserController < ApplicationController
    def create
        @user = User.new(user_param)
        if @user.save
            UserMailer.registration_confirmation(@user).deliver
            json_response({:user=>@user.as_json(except: [:password_digest, :confirm_token])}, 200)
        else
            json_response({}, 401, @user.errors.full_messages)
        end
    end

    protected

    def user_param
        params.required(:user).permit(:first_name, :last_name, :email,:password, :gender)
    end
end
