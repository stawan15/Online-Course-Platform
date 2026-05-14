class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [ :show, :edit, :update, :destroy ]
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  load_and_authorize_resource param_method: :enrollment_params, except: [ :restore ]
  before_action :set_paper_trail_whodunnit

  def index
    @enrollments = Enrollment.all
    @deleted_enrollments = Enrollment.only_deleted
  end

  def show
    @enrollment = Enrollment.find(params[:id])
  end

  def new
    @enrollment = Enrollment.new
  end
  def edit
    # edit function
    @enrollment = Enrollment.find(params[:id])
    @users = User.all
    @courses = Course.all
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)
    if @enrollment.save
      redirect_to @enrollment
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # update function
    @enrollment = Enrollment.find(params[:id])
    if @enrollment.update(enrollment_params)
      redirect_to @enrollment
    else
      render :edit
    end
  end

  def destroy
    @enrollment.destroy
    redirect_to enrollments_path, notice: "ย้ายการลงทะเบียนไปที่ถังขยะเรียบร้อยแล้ว"
  end

  def restore
    @enrollment = Enrollment.only_deleted.find(params[:id])
    authorize! :restore, @enrollment
    @enrollment.restore
    redirect_to enrollments_path, notice: "กู้คืนการลงทะเบียนเรียบร้อยแล้ว"
  end

  private

  def set_enrollment
    @enrollment = Enrollment.find(params[:id])
  end

  def enrollment_params
    params.require(:enrollment).permit(:user_id, :course_id)
  end
end
