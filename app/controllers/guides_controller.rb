# coding: utf-8
class GuidesController < ApplicationController
  
  def intro
  end

  def reader
  end

  def finish
    @page_title = "学業成績・総合"
    @meta_description = "大学の授業の新しい形、OpenCollege。"
  end

end
