class CoursesController < ApplicationController
  # ตั้งค่าคอร์สก่อนเริ่ม action สำหรับ show, edit, update, destroy
  before_action :set_course, only: [ :show, :edit, :update, :destroy ]
  # ยกเว้นการตรวจสอบการเข้าสู่ระบบสำหรับหน้า index และ show
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  # โหลดและตรวจสอบสิทธิ์การใช้งาน
  load_and_authorize_resource param_method: :course_params, except: [ :restore ]
  # ตั้งค่าผู้กระทำสำหรับระบบติดตามการเปลี่ยนแปลง (Paper Trail)
  before_action :set_paper_trail_whodunnit

  # แสดงรายการคอร์สทั้งหมด
  def index
    @courses = Course.all
    @deleted_courses = Course.only_deleted
  end

  # แสดงรายละเอียดของคอร์ส
  def show
    @course = Course.find(params[:id])
  end

  # สร้างคอร์สใหม่ (แสดงฟอร์ม)
  def new
    @course = Course.new
  end

  # แก้ไขคอร์ส (แสดงฟอร์ม)
  def edit
    @course = Course.find(params[:id])
  end

  # บันทึกคอร์สใหม่ลงในฐานข้อมูล
  def create
    @course = current_user.taught_courses.build(course_params)
    if @course.save
      redirect_to @course, notice: "สร้างคอร์สเรียบร้อยแล้ว"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # อัปเดตข้อมูลคอร์สที่มีอยู่
  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to @course
    else
      render :edit
    end
  end

  # ลบคอร์ส (ย้ายไปที่ถังขยะ)
  def destroy
    @course.destroy
    redirect_to courses_path, notice: "ย้ายคอร์สไปที่ถังขยะเรียบร้อยแล้ว"
  end

  # กู้คืนคอร์สที่เคยลบไปแล้ว
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

  # ตั้งค่า @course จาก ID ในพารามิเตอร์
  def set_course
    @course = Course.find(params[:id])
  end

  # กำหนดพารามิเตอร์ที่อนุญาตให้บันทึกได้
  def course_params
    params.require(:course).permit(:title, :description)
  end
end
