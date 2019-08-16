class DmChannel < ApplicationCable::Channel
  def subscribed
    stream_from "dm_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast("dm_#{params[:room]}", data)
  end
  
end
