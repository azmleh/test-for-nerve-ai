class WelcomeController < ApplicationController
  
  before_action :set_user, except: [:index, :registration]
  #before_action :require_login, except: [:index, :registration]
  
  def index
    render
  end
  
  def game
    render locals: { games: @user.games }
  end
  
  def registration
    @user = User.find_by(email: email)
    @user = User.create!(email: email, key: gen_key) unless @user
    @user.update(key: gen_key) unless @user.key
    session[:user] = @user.id
    render locals: { key: @user.key }
  rescue
    redirect_to index_url
  end
  
  def confirm
    if @user.key == key
      authorize
      redirect_to game_url
    else
      redirect_to index_url
    end
  end
    
  protected
  
    def email
      params.require(:email)
      params[:email]
    end
    
    def key
      params.require(:key)
      params[:key]
    end
    
    def gen_key
      (0..9).to_a.sample(5).join
    end
  
end