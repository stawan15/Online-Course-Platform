class Profile < ApplicationRecord
  acts_as_paranoid
  has_paper_trail
  belongs_to :user
  attr_accessor :role, :email, :name
end
