class UsersController < ApplicationController
    def create
      @user = User.new(user_params)
      if @user.save
        flash[:notice] = "Account created successfully!"
        Rails.logger.info "🟡Flash notice set: #{flash[:notice]}"
        redirect_to login_path
      else
        flash[:alert] = @user.errors.full_messages.join(', ')
        Rails.logger.info "🔴Flash alert set: #{flash[:alert]}"
        redirect_to signup_path
      end
    end
  
    private
  
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
  