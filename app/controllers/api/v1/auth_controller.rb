class Api::V1::AuthController < ApplicationController
    def create
        @user = User.find_by_email(auth_param[:email])
        if @user&.authenticate(auth_param[:password])
          token = JsonWebToken.encode(user_id: @user.id)
          render :json => {:success=> true, :token => token, :user=> @user.as_json(except: [:password_digest])}, status: :ok
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end


    def update
      user = User.find_by_confirm_token(params[:id])
      if user 
        user.email_activate
        render :json => {:success=> true, :user=> user.as_json(except: [:password_digest, :confirm_token])}, status: :ok        
      else
        render :json => {:success=> false, :message=> "invalid code"}, status: :bad_request
      end
    end

    protected

    def auth_param
        params.required(:auth).permit(:email,:password)
    end
end
