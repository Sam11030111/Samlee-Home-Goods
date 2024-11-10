class LoginController < ApplicationController
    def index
        @user = User.new
    end

    def create
        @user = User.find_by(email: params[:user][:email])
    
        if @user&.authenticate(params[:user][:password])
          # Store user ID in the session to keep the user logged in
          session[:user_id] = @user.id
    
          # Set a cookie for persistent login
          cookies.signed[:samlee_home_goods_user_id] = { value: @user.id, expires: 2.weeks.from_now }
    
          flash[:notice] = "Login successfully!"
          redirect_to root_path
        else
          flash[:alert] = "Invalid email or password"
          render "login/index", status: :unprocessable_entity, content_type: "text/html"
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end