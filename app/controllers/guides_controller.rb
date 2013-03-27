# coding: utf-8
class GuidesController < ApplicationController
  
  def intro
  end

  def reader
  end

  def finish
  	@user = current_user
    @rank_all_in_university = ClassGrade.select('user_id, 1.0 * sum(grade)/count(grade) gpa').group('user_id').to_a.map{|x|sprintf( "%.2f", x.gpa )}.sort{|a, b| b <=> a}.index(@user.calculate) + 1

    @rank_all_in_department = @user.department.class_grades.select('user_id, 1.0 * sum(grade)/count(grade) gpa').group('user_id').to_a.map{|x|sprintf( "%.2f", x.gpa )}.sort{|a, b| b <=> a}.index(@user.calculate) + 1

    @rank_all_in_school_subject = @user.school_subject.class_grades.select('user_id, 1.0 * sum(grade)/count(grade) gpa').group('user_id').to_a.map{|x|sprintf( "%.2f", x.gpa )}.sort{|a, b| b <=> a}.index(@user.calculate) + 1
    @page_title = "学業成績・総合"
    @meta_description = "大学の授業の新しい形、OpenCollege。"
  end

end
