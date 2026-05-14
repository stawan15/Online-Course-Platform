class QuizSubmission < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
end
