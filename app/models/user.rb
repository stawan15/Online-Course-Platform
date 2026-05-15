class User < ApplicationRecord
  # จัดการบทบาท (roles) ของผู้ใช้
  rolify
  # เปิดใช้งาน soft delete (ลบแบบชั่วคราว)
  acts_as_paranoid
  # ติดตามประวัติการเปลี่ยนแปลงของข้อมูล
  has_paper_trail

  # ความสัมพันธ์: หนึ่งผู้ใช้มีหนึ่งโปรไฟล์
  has_one :profile

  # ความสัมพันธ์: รายการที่ผู้ใช้ลงทะเบียนเรียน
  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course

  # ความสัมพันธ์: คอร์ส บทเรียน และควิซที่ผู้ใช้คนนี้เป็นผู้สอน
  has_many :taught_courses, class_name: "Course", foreign_key: "user_id"
  has_many :taught_lessons, through: :taught_courses, source: :lessons
  has_many :taught_quizzes, through: :taught_lessons, source: :quizzes

  # ความสัมพันธ์: การส่งคำตอบควิซ (ถูกลบเมื่อผู้ใช้ถูกลบออกจากระบบ)
  has_many :quiz_submissions, dependent: :destroy

  # การตั้งค่าโมดูล Devise สำหรับการตรวจสอบตัวตน
  # :confirmable, :lockable, :timeoutable, :trackable และ :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
