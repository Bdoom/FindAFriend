# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[show edit update destroy]

  def create_new_message
    convo = Conversation.find params[:conversation_id]

    if convo.sender_id == current_user.id || convo.recipient_id == current_user.id
      message_body = params[:message_body]
      message = Message.create!(user: current_user, conversation_id: convo.id, message_body: message_body)

      convo.messages << message unless message.nil?

      render json: { status: 'ok' }
    else
      render json: { status: 'fail' }
    end
  end

  def get_recent_messages
    convo = Conversation.find params[:conversation_id]
    @messages = nil

    redirect_to root_path unless user_signed_in?

    if convo.sender_id == current_user.id || convo.recipient_id == current_user.id
      @messages = convo.messages.last(10)
    end

    render json: { messages: @messages }
  end

  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = Conversation.where(sender: current_user.id) + Conversation.where(recipient: current_user.id)
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
    @conversation = Conversation.new(conversation_params)

    respond_to do |format|
      if @conversation.save
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
