class ApplicationController < ActionController::Base
  
  protected
  
    def authorized?
      return !!@user.auth_at
    end
    
    def authorize
      @user.auth_at = Time.now
      @user.key = nil
      @user.save
    end
    
    def require_login
      redirect_to game_url if authorized?
    end
    
    def log_out
      @user.auth_at = nil
      @user.key = nil
      @user.save
    end
    
    def set_user
      @user ||= User.find session[:user]
      pp 'USER', @user
    rescue
      redirect_to index_url
    end
  
end
