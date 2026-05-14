class Quiz < ApplicationRecord
  acts_as_paranoid
  has_paper_trail
  belongs_to :lesson
  has_many :quiz_submissions, dependent: :destroy
end
