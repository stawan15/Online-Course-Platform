class AddMissingColumnsToAllTables < ActiveRecord::Migration[8.1]
  def change
    # Users
    add_column :users, :role, :string unless column_exists?(:users, :role)

    # Courses
    add_column :courses, :description, :text unless column_exists?(:courses, :description)
    add_reference :courses, :user, foreign_key: true unless column_exists?(:courses, :user_id)

    # Lessons
    add_column :lessons, :title, :string unless column_exists?(:lessons, :title)
    add_column :lessons, :description, :text unless column_exists?(:lessons, :description)
    add_reference :lessons, :course, foreign_key: true unless column_exists?(:lessons, :course_id)

    # Quizzes
    add_column :quizzes, :question, :string unless column_exists?(:quizzes, :question)
    add_reference :quizzes, :lesson, foreign_key: true unless column_exists?(:quizzes, :lesson_id)

    # Enrollments
    add_reference :enrollments, :user, foreign_key: true unless column_exists?(:enrollments, :user_id)
    add_reference :enrollments, :course, foreign_key: true unless column_exists?(:enrollments, :course_id)

    # Profiles
    add_reference :profiles, :user, foreign_key: true unless column_exists?(:profiles, :user_id)
    add_column :profiles, :bio, :text unless column_exists?(:profiles, :bio)
  end
end
