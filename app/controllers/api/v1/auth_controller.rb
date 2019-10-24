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


    protected

    def auth_param
        params.required(:auth).permit(:email,:password)
    end
end
