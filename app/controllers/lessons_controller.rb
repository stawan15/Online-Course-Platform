class LessonsController < ApplicationController
  before_action :set_lesson, only: [ :show, :edit, :update, :destroy ]
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  load_and_authorize_resource param_method: :lesson_params, except: [ :restore ]
  before_action :set_paper_trail_whodunnit

  def index
    @lessons = Lesson.all
    @deleted_lessons = Lesson.only_deleted
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  def new
    @lesson = Lesson.new
  end
  def edit
    @lesson = Lesson.find(params[:id])
  end

  def create
    @lesson = current_user.taught_lessons.build(lesson_params)
    if @course.save
      redirect_to @course, notice: "สร้างคอร์สเรียบร้อยแล้ว"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @lesson = Lesson.find(params[:id])
    if @lesson.update(lesson_params)
      redirect_to @lesson
    else
      render :edit
    end
  end

  def destroy
    @lesson.destroy
    redirect_to lessons_path, notice: "ย้ายบทเรียนไปที่ถังขยะเรียบร้อยแล้ว"
  end

  def restore
    @lesson = Lesson.only_deleted.find(params[:id])
    authorize! :restore, @lesson
    @lesson.restore
    redirect_to lessons_path, notice: "กู้คืนบทเรียนเรียบร้อยแล้ว"
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :description)
  end
end
