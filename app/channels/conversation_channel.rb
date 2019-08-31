# frozen_string_literal: true

class ConversationChannel < ApplicationCable::Channel
  # calls when a client connects to the server
  def subscribed
    if params[:conversation_id].present?
      # creates a private chat room with a unique name
      stream_from("Conversation-#{params[:conversation_id]}")

      convo = Conversation.find params[:conversation_id]

      unless convo.nil?
        user = User.find params[:user_id]
        user.status = 'Online'
        user.save!
        unless convo.users.include? user
          convo.users << user unless user.nil?
        end
      end

    end
  end

  def unsubscribed
    user = User.find params[:user_id]

    user.status = 'Offline' unless user.nil?
    user.save!
  end

  def receive(data)
    ActionCable.server.broadcast("Conversation-#{params[:conversation_id]}", data)
  end
end
