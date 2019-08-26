# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def show

  end

  def new
    test = params[:test]
    puts "testing: #{test}"
    @conversation = Conversation.new
  end
  

  def index
    @users = User.all
    @conversations = Conversation.all
  end

  def create
    puts "params: #{params[:conversation]}"
    user1 = User.find params[:conversation][:sender]
    user2 = User.find params[:conversation][:recipient]
    if Conversation.between(params[:conversation][:sender], params[:conversation][:recipient]).present?
      @conversation = Conversation.between(params[:conversation][:sender],
                                           params[:conversation][:recipient]).first
    else
        
        @conversation = Conversation.create!(sender: user1, recipient: user2)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
