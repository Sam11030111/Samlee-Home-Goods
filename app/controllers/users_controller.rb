class UsersController < ApplicationController
    def create
      @user = User.new(user_params)
      if @user.save
        flash[:notice] = "Account created successfully!"
        Rails.logger.info "🟡Flash notice set: #{flash[:notice]}"
        redirect_to login_path
      else
        puts "🔴 Errors: #{@user.errors.full_messages}"
        render "signup/index", status: :unprocessable_entity, content_type: "text/html"
      end
    end
  
    private
  
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
  