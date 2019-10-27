class Api::V1::AuthController < ApplicationController
    def create
        @user = User.find_by_email(auth_param[:email])
        if @user&.authenticate(auth_param[:password])
          if @user.email_confirmed
            token = JsonWebToken.encode(user_id: @user.id)
            json_response({:token => token, :user=> @user.as_json(except: [:password_digest, :confirm_token])}, 200)
          else
            json_response({}, 401, "Sorry!!! Email not confirmed")
          end
        else
          json_response({}, 401, "Sorry!!! unauthorized")
        end
    end


    def update
      user = User.find_by_confirm_token(params[:id])
      if user 
        user.email_activate
        json_response({:user=> user.as_json(except: [:password_digest, :confirm_token])}, 200)
      else
        json_response({}, 401, "Sorry!!! invalid code")
      end
    end

    protected

    def auth_param
        params.required(:auth).permit(:email,:password)
    end
end
