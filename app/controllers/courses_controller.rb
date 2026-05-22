class CoursesController < ApplicationController
  before_action :set_course, only: [ :show, :edit, :update, :destroy ]
  before_action :set_paper_trail_whodunnit
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  load_and_authorize_resource param_method: :course_params, except: [ :restore ]

  def index
    @courses = Course.all
    @deleted_courses = Course.only_deleted
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
    @course = current_user.taught_courses.build(course_params)
    if @course.save
      redirect_to @course, notice: "สร้างคอร์สเรียบร้อยแล้ว"
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
    @course.destroy
    redirect_to courses_path, notice: "ย้ายคอร์สไปที่ถังขยะเรียบร้อยแล้ว"
  end

  def restore
    Rails.logger.debug { "Attempting to restore course with ID: #{params[:id]}" }
    @course = Course.only_deleted.find(params[:id])
    Rails.logger.debug { "Course found: #{@course.inspect}" }
    authorize! :restore, @course
    Rails.logger.debug { "Authorization passed for restore action." }
    @course.restore
    redirect_to courses_path, notice: "กู้คืนคอร์สเรียบร้อยแล้ว"
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end
  def course_params
    params.require(:course).permit(:title, :description)
  end
end
