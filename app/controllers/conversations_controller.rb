# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[show edit update destroy]
  #before_action :logged_in?

  def logged_in?
    unless user_signed_in?
      redirect_to root_path, notice: 'You must be logged in to view this page.'
    end
  end

  def show_chat_rooms
    render 'conversations/chatrooms'
  end

  def create_new_message
    convo = Conversation.find params[:conversation_id]

    if convo.users.include? current_user
      message_body = params[:message_body]
      message = Message.create!(first_name: params[:first_name], user: current_user, conversation_id: convo.id, message_body: message_body)

      convo.messages << message unless message.nil?

      render json: { status: 'ok' }
    else
      render json: { status: 'fail' }
    end
  end

  def get_recent_messages
    convo = Conversation.find params[:conversation_id]
    @messages = nil
    @page = params[:page].to_i

    if @page * 50 > convo.messages.count 
      @messages = convo.messages.order("created_at ASC").last(convo.messages.count)
      render json: { messages: @messages }
    else
      if convo.users.include? current_user
        #@messages = convo.messages.paginate(page: params[:page], per_page: 50).order("created_at ASC")
        @messages = convo.messages.order("created_at ASC").last(50 * @page)

      elsif !convo.topic.nil?
        #@messages = convo.messages.paginate(page: params[:page], per_page: 50).order("created_at ASC")
        @messages = convo.messages.order("created_at ASC").last(50 * @page)
      end

      render json: { messages: @messages }
    end
  end

  def get_users_in_conversation
    convo = Conversation.find params[:conversation_id]
    @users = nil

    if convo.users.include? current_user
        @users = convo.users
    end

    render json: { users: @users }, except: [:email, :invite_code]
  end

  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = current_user.conversations
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
  end

  # GET /conversations/1/edit
  def edit; end

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = Conversation.new

    respond_to do |format|
      if @conversation.save

        recipient_user = User.find conversation_params[:recipient_id]
        @conversation.users << current_user unless current_user.nil?
        @conversation.users << recipient_user unless recipient_user.nil?

        format.html { redirect_to @conversation, notice: 'Conversation was successfully created.' }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { render :new }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def conversation_params
    params.fetch(:conversation, {}).permit(:sender_id, :recipient_id)
  end
end
