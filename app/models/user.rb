class User < ApplicationRecord
  rolify
  acts_as_paranoid
  has_paper_trail

  has_one :profile

  has_many :enrollments
  has_many :courses, through: :enrollments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
