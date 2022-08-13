class ChatsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @chat = current_customer.chats.new(chat_params)
    if @chat.save
      redirect_to request.referer
    else
      render :error
    end
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to room_path(@chat.room.id)
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
