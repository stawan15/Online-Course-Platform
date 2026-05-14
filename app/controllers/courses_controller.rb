class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def edit
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to @course
    else
      render :edit
    end
  end

  def destroy
    if @course.destroy
      render json: { message: "Deleted successfully" }, status: :ok
      redirect_to courses_path
    else
      render json: { error: @course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.require(:course).permit(:title, :description)
  end
end
