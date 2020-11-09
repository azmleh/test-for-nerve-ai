class GameChannel < ApplicationCable::Channel
  
  def subscribed
    puts 'SUBSCRIBED', params
    
    stream_for "game_stream:#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  
  def move(data)
    puts 'MOVE'
    ActionCable.server.broadcast("game:game_stream:#{params[:id]}", processing: true, status: 200)
    result = GameService.make_move(params[:id], data)
    ActionCable.server.broadcast("game:game_stream:#{params[:id]}", cell: data, result: result, status: 200)
  end
end
