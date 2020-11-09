module Api
  class MatchesController < ApplicationController
    
    def show
      match = Match.find(params[:id])
      
      if match.owner_id == session[:user]
        player = 'x'
      else
        if match.opponent_id
          player = match.opponent_id == session[:user] ? 'o' : nil
        else
          match.opponent_id = session[:user]
          player = 'o'
        end
      end
      
      field = GameService.new(match).field

      render json: { match: match, player: player, field: field }.to_json
    end
    
  end
end
