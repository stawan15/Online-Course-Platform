class Lesson < ApplicationRecord
  acts_as_paranoid
  has_paper_trail
  belongs_to :course
  has_many :quizzes
end
