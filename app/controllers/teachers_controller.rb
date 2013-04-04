class TeachersController < ApplicationController
  def show
    @teacher = Teacher.find(params[:id])
    respond_to do |format|
      format.html
      format.mobile
    end
  end
end
