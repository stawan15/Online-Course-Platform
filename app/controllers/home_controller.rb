class HomeController < ApplicationController
  def index
    @recent_courses = Course.order(created_at: :desc).limit(3)
  end

  def show
    @course = Course.find(params[:id])
  end
end
