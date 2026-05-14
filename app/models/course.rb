class Course < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  belongs_to :user
  has_many :lessons

  has_many :enrollments
  has_many :users, through: :enrollments
end
