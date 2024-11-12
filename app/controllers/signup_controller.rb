class SignupController < ApplicationController
  def index
    @user = User.new
    @current_step = 1
  end

  def step1
    @user = User.new(step1_params)
    @current_step = 1
    
    if step1_valid?(@user)
      session[:user_params] = step1_params
      redirect_to signup_step2_path
    else
      puts "🔴 Step1 Error: #{@user.errors.full_messages}"
      render :index, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  def step2
    @user = User.new(session[:user_params])
    @current_step = 2
    puts "🟢 Step2 Session Data: #{session[:user_params]}"
  end

  def create
    @current_step = 2
    puts "🟢 Session Data Before Merge: #{session[:user_params]}"
    @user = User.new(session[:user_params].merge(user_params))

    if @user.save
      flash[:notice] = "Account created successfully!"
      session[:user_params] = nil
      Rails.logger.info "🟡 Flash notice set: #{flash[:notice]}"
      redirect_to login_path
    else
      puts "🔴 Signup Error: #{@user.errors.full_messages}"
      render :step2, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  private

  # Define the required fields for Step 1 validation
  def step1_valid?(user)
    required_fields = [:first_name, :last_name, :street, :city, :postal_code, :province_id]
    valid = true

    required_fields.each do |field|
      if user[field].blank?
        user.errors.add(field, "can't be blank")
        valid = false
      end
    end

    valid
  end

  # Parameters for Step 1 fields only
  def step1_params
    params.require(:user).permit(:first_name, :last_name, :street, :city, :postal_code, :province_id)
  end

  # Parameters for final creation
  def user_params
    params.require(:user).permit(:first_name, :last_name, :street, :city, :postal_code, :province_id, :email, :password, :password_confirmation)
  end
end
