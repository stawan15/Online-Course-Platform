class Course < ApplicationRecord
  # เปิดใช้งาน soft delete (ลบแบบชั่วคราว)
  acts_as_paranoid
  # ติดตามประวัติการเปลี่ยนแปลงของข้อมูล
  has_paper_trail

  # ความสัมพันธ์: คอร์สนี้เป็นของอาจารย์ผู้สอน (User)
  belongs_to :user
  # ความสัมพันธ์: คอร์สนี้มีหลายบทเรียน (Lessons)
  has_many :lessons

  # ความสัมพันธ์: มีการลงทะเบียนหลายรายการ
  has_many :enrollments
  # ความสัมพันธ์: มีผู้เรียนหลายคนผ่านการลงทะเบียน
  has_many :users, through: :enrollments
end
