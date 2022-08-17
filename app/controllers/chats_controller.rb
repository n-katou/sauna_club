# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @chat = current_customer.chats.new(chat_params)
    if @chat.save
      @chat = current_customer.chats.new(chat_params)
      room = Room.find(params[:chat][:room_id])
      @chats = room.chats.includes(:customer).order("created_at DESC").page(params[:page]).per(5)
      # redirect_to request.referer
    else
      room = Room.find(params[:chat][:room_id])
      @chats = room.chats.includes(:customer).order("created_at DESC").page(params[:page]).per(5)
      render :error
    end
  end

  def destroy
    @chat = Chat.find(params[:id])
    room = @chat.room
    @chat.destroy
    respond_to do |format|
     format.html { redirect_to room_path(@chat.room.id) }
     format.js {
      @chats = room.chats.includes(:customer).order("created_at DESC").page(params[:page]).per(5)
      render 'chats/destroy.js.erb' }
   end
    # redirect_to room_path(@chat.room.id)
  end

  def edit
    @chat = Chat.find(params[:id])
  end

  def update
    @chat = Chat.find(params[:id])
    if @chat.update(chat_params)
      redirect_to room_path(@chat.room.id)
    else
      render :edit
    end
  end

  private
    def chat_params
      params.require(:chat).permit(:message, :room_id)
    end
end
