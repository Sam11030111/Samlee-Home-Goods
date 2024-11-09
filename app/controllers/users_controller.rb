class UsersController < ApplicationController
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to root_path, notice: "Account created successfully!"
      else
        # Output validation errors to Rails logs
        Rails.logger.info(@user.errors.full_messages)
        render 'signup/index'  # Renders the signup form with errors if validation fails
      end
    end
  
    private
  
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
  