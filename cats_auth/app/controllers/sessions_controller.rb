class SessionsController < ApplicationController
  
  def new 
    render :new 
  end
   
  def create 
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    #^ a user must exist in order to login
    if user.nil?
      render json: 'Credentials were wrong'
    else 
      login!(user)
      redirect_to user_url(user)
    end 
    
  end 
  
  
  def destroy
    logout!
    # redirect_to new_session_url
  end 
  
  
end 