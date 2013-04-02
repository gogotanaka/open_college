# coding: utf-8
class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:index, :show, :edit, :update]
  before_filter :correct_user, only: [:show, :profile, :edit, :update]
  before_filter :admin_user, only: [:index, :source, :destroy]

  def index
    @users = User.order("id").all
  end

  def show
    @user = User.find(params[:id])
    if @user.university
      @rank_all_in_university = ClassGrade.select('user_id, 1.0 * sum(grade)/count(grade) gpa').group('user_id').to_a.map{|x|sprintf( "%.2f", x.gpa )}.sort{|a, b| b <=> a}.index(@user.calculate) + 1
      @rank_all_in_department = @user.department.class_grades.select('user_id, 1.0 * sum(grade)/count(grade) gpa').group('user_id').to_a.map{|x|sprintf( "%.2f", x.gpa )}.sort{|a, b| b <=> a}.index(@user.calculate) + 1
      @rank_all_in_school_subject = @user.school_subject.class_grades.select('user_id, 1.0 * sum(grade)/count(grade) gpa').group('user_id').to_a.map{|x|sprintf( "%.2f", x.gpa )}.sort{|a, b| b <=> a}.index(@user.calculate) + 1
      respond_to do |format|
        format.html
        format.mobile
      end
    else
      flash[:error] = '成績の解析が完了していません。もう一度誘導にしたがってやり直してください。解析が完了したら、OpenCollegeを使うことができます。解析したデータは匿名で、大学の授業をオープンにすること、あなたの授業選びのツール、のみに使われます。'
      redirect_to intro_guide_url(@user)
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.mobile
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "ようこそ、OpenCollegeへ！すべてのStepを終えたら、OpenCollegeを使うことができます。所要時間は約3分です。"
      redirect_to intro_guide_url(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.mobile
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def profile
    @user = User.find(params[:id])
  end

  def source
    @user = User.find(params[:id])
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

    def admin_user
      redirect_to(root_path) unless current_user.id == 1 || current_user.admin?
    end

end
