class ClassRoomsController < ApplicationController

  def index
  end

  def show
    @class_room = ClassRoom.find(params[:id])
    @page_title = @class_room.name
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
