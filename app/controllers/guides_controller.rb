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
    @user = User.find(params[:id])
    if @user.university
    	@user = current_user
      @rank_all_in_university = @user.university.rank(@user.school_year).index(@user.calculate) + 1
      @rank_all_in_department = @user.department.rank(@user.school_year).index(@user.calculate) + 1
      @rank_all_in_school_subject = @user.school_subject.rank(@user.school_year).index(@user.calculate) + 1
      @page_title = "学業成績・総合"
      @meta_description = "大学の授業の新しい形、OpenCollege。"
      respond_to do |format|
        format.html
        format.mobile
      end
    else
      flash[:error] = '成績の解析が完了していません。もう一度誘導にしたがってやり直してください。解析が完了したら、OpenCollegeを使うことができます。解析したデータは匿名で、大学の授業をオープンにすること、あなたの授業選びのツール、のみに使われます。'
      redirect_to intro_guide_url(@user)
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
      redirect_to intro_guide_url(current_user) unless current_user?(@user)
    end
end
