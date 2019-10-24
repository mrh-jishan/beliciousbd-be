class Api::V1::UserController < ApplicationController
    def create
        @user = User.new(user_param)
        if @user.save
            render :json => {:success=> true, :user=> @user.as_json(except: [:password_digest])}, status: :ok
        else
            render :json => {:success=> false, :message=> @user.errors.full_messages}, status: :bad_request
        end
    end


    protected

    def user_param
        params.required(:user).permit(:first_name, :last_name, :email,:password, :gender)
    end
end
