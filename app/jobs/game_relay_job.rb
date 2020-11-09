class GameRelayJob < ApplicationJob
  def perform
    ActionCable.server.broadcast("game:game_stream", message: "message", status: 200)
  end
end