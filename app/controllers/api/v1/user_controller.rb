class Api::V1::UserController < ApplicationController
    def create
        @user = User.new(user_param)
        if @user.save
            UserMailer.registration_confirmation(@user).deliver
            render :json => {:success=> true, :user=> @user.as_json(except: [:password_digest, :confirm_token])}, status: :ok
        else
            render :json => {:success=> false, :message=> @user.errors.full_messages}, status: :bad_request
        end
    end


    # def confirm_email
    #     user = User.find_by_confirm_token(params[:id])
    #     if user
    #       user.email_activate
    #       flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
    #       Please sign in to continue."
    #       redirect_to signin_url
    #     else
    #       flash[:error] = "Sorry. User does not exist"
    #       redirect_to root_url
    #     end
    # end


    protected

    def user_param
        params.required(:user).permit(:first_name, :last_name, :email,:password, :gender)
    end
end
