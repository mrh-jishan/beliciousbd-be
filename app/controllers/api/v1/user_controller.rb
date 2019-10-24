class Api::V1::UserController < ApplicationController
    def create
        @user = User.new(user_param)
        if @user.save
            render :json => {:success=> true, :user=> @user}
        else
            render :json => {:success=> false, :message=> @user.errors.full_messages}
        end
    end


    protected

    def user_param
        params.required(:user).permit(:first_name, :last_name, :email,:password, :gender)
    end
end
