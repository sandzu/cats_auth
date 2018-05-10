class UsersController < ApplicationController 
  before_action :require_current_user!, except: [:create, :new]
  def index
    render :index 
  end 
  
  def new
    @user = User.new 
    render :new 
  end 
  
  def create 
  
    @user = User.new(user_params)
    if @user.save!
      login!(@user) #automatically log in when a new user is created 
      render json: @user
    else 
      render json: @users.errors.full_messages
      render :new 
    end 
  end 
  
  def show
    render json: User.find(params[:id])
  end 
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end 
  
end 