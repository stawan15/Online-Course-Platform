class User < ApplicationRecord
  rolify
  acts_as_paranoid
  has_paper_trail

  has_one :profile

  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :taught_courses, class_name: "Course", foreign_key: "user_id"
  has_many :taught_lessons, through: :taught_courses, source: :lessons
  has_many :taught_quizzes, through: :taught_lessons, source: :quizzes
  has_many :quiz_submissions, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
