class ApplicationController < ActionController::API
    def index
        @users = User.all
        render :json => {:success=> true, :user=> @users}
    end
end
