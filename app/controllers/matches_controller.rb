class MatchesController < ApplicationController
  
  before_action :set_user, only: [:create, :show]
  
  def index
    render
  end
  
  def show
    set_match
    render
  end
  
  def create
    #render :show
    match = Match.create!(owner_id: @user.id)
    redirect_to match
  end
  
  private
  
    def set_match
      @match = Match.find params[:id]
    end
  
end