# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.where(sender_id: current_user.id)
  end

  def open_conversation
    sender = current_user.id
    recipient = params[:recipient]
    if Conversation.between(sender, recipient).present?
      @conversation = Conversation.between(sender,
                                           recipient).first
    else
      @conversation = Conversation.create!(sender: sender, recipient: recipient)
    end
    render 'conversations/conversation'
  end

end
