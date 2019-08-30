# frozen_string_literal: true

class ConversationChannel < ApplicationCable::Channel
  # calls when a client connects to the server
  def subscribed
    if params[:conversation_id].present?
      # creates a private chat room with a unique name
      stream_from("Conversation-#{params[:conversation_id]}")
    end
  end

  def receive(data)
    ActionCable.server.broadcast("Conversation-#{params[:conversation_id]}", data)
  end
end
