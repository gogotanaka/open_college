class ClassRoomsController < ApplicationController

  before_filter :signed_in_user
  before_filter :admin_user, only: [:index, :show]

  def index
    @class_room_for_years = ClassRoomForYear.includes(:users).sort_by{|u| u.users.size}.reverse[0..100]
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

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def admin_user
      redirect_to(root_path) unless current_user.id == 1 || current_user.admin?
    end


end
