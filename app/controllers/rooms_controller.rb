class RoomsController < ApplicationController
  before_action :authenticate_customer!
  before_action :same_room_customer!, only: [:show]

  def index
    my_rooms_ids = current_customer.customer_rooms.select(:room_id)
    @customer_rooms = CustomerRoom.includes(:chats, :customer).where(room_id: my_rooms_ids)
                                  .where.not(customer_id: current_customer.id).reverse_order
  end

  def create
    @customer = Customer.find(params[:customer_id])
    customer_rooms = CustomerRoom.find_customer_rooms(current_customer, @customer)
    if customer_rooms.nil?
      room = Room.create
      CustomerRoom.create(customer_id: current_customer.id, room_id: room.id)
      CustomerRoom.create(customer_id: @customer.id, room_id: room.id)
    else
      room = customer_rooms.room
    end
    redirect_to room_path(room.id)
  end

  def show
    room = Room.find(params[:id])
    room.check_chats_notification(current_customer)
    customer_id = room.customer_rooms.where.not(customer_id: current_customer.id).select(:customer_id)
    @customer = Customer.where(id: customer_id).first
    @chats = room.chats.includes(:customer).page(params[:page]).per(5)
    @chat = Chat.new(room_id: room.id)
  end

  private

  def same_room_customer!
    return if Room.find(params[:id]).customers.include?(current_customer)
    flash[:danger] = "ユーザーにはアクセスする権限がありません"
    redirect_to root_path
  end

  # def show
  #   @customer = Customer.find(params[:id])
  #   rooms = current_customer.customer_rooms.pluck(:room_id)
  #   customer_rooms = CustomerRoom.find_by(customer_id: @customer.id, room_id: rooms)

  #   if customer_rooms.nil?
  #     @room = Room.new
  #     @room.save
  #     CustomerRoom.create(customer_id: @customer.id, room_id: @room.id)
  #     CustomerRoom.create(customer_id: current_customer.id, room_id: @room.id)
  #   else
  #     @room = customer_rooms.room
  #   end

  #   @chats = @room.chats.order("created_at DESC").page(params[:page]).per(5)
  #   @chat = Chat.new(room_id: @room.id)
  # end

end
