class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :curent_user
  
  def login!(user)
    @curent_user = user 
    session[:session_token] = user.session_token 
  end 
  
  def current_user 
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end 
  
  def login_user!
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    #^ a user must exist in order to login
    if user.nil?
      render json: 'Credentials were wrong'
    else 
      login!(user)
      redirect_to user_url(user)
    end 
    
  end 
  
  def require_current_user!
    redirect_to new_session_url if self.current_user.nil?
  end 
  
  def logout!
    @current_user.reset_session_token! if current_user
    session[:session_token] = nil
    @current_user = nil 
  end 
  

  
end
