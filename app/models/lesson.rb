class Lesson < ApplicationRecord
  acts_as_paranoid
  has_paper_trail
  belongs_to :course
  has_many :quizzes

  def youtube_embed_id
    return nil if youtube_url.blank?

    # Handles https://www.youtube.com/watch?v=VIDEO_ID and https://youtu.be/VIDEO_ID
    if youtube_url[/youtu\.be\/([^\?\/]+)/]
      $1
    elsif youtube_url[/v=([^\&\/]+)/]
      $1
    end
  end
end
