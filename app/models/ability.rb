class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest (not logged in)

    if user.has_role? :admin
      can :manage, :all
      # Allow restoring courses
      can :restore, Course if user.has_role?(:admin)
    else
        # ปรับปรุงสิทธิ์พื้นฐานให้สะอาดขึ้น
        can :read, [ Course, Lesson, Quiz, User, Profile, Enrollment ]
        # สามารถแก้ไข Profile ของตัวเองได้
        can :manage, Profile, user_id: user.id
      # สามารถดู Enrollment ของตัวเองได้
      can :read, Enrollment, user_id: user.id
    end
  end
end
