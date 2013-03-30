# coding: utf-8
class GuidesController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user
  
  def intro
    respond_to do |format|
      format.html
      format.mobile
    end
  end

  def reader
    respond_to do |format|
      format.html
      format.mobile
    end
  end

  def finish
  	@user = current_user
    @rank_all_in_university = ClassGrade.select('user_id, 1.0 * sum(grade)/count(grade) gpa').group('user_id').to_a.map{|x|sprintf( "%.2f", x.gpa )}.sort{|a, b| b <=> a}.index(@user.calculate) + 1
    @rank_all_in_department = @user.department.class_grades.select('user_id, 1.0 * sum(grade)/count(grade) gpa').group('user_id').to_a.map{|x|sprintf( "%.2f", x.gpa )}.sort{|a, b| b <=> a}.index(@user.calculate) + 1
    @rank_all_in_school_subject = @user.school_subject.class_grades.select('user_id, 1.0 * sum(grade)/count(grade) gpa').group('user_id').to_a.map{|x|sprintf( "%.2f", x.gpa )}.sort{|a, b| b <=> a}.index(@user.calculate) + 1
    @page_title = "学業成績・総合"
    @meta_description = "大学の授業の新しい形、OpenCollege。"
    respond_to do |format|
      format.html
      format.mobile
    end
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
