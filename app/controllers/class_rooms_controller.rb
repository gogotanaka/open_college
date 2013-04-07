class ClassRoomsController < ApplicationController

  def index
    @class_rooms = ClassRoomForYear.joins(:class_rooms).first
  end

  def show
    @class_room = ClassRoom.find(params[:id])
  end

  def new
    @class_room = ClassRoom.new
  end

  def create
    @class_room = ClassRoom.new(params[:class_room])
    if @class_room.save
      flash[:success] = "ClassRoom Created!"
      redirect_to @class_room
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end


end
