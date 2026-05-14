class AddDeletedAtToQuizzes < ActiveRecord::Migration[8.1]
  def change
    add_column :quizzes, :deleted_at, :datetime
    add_index :quizzes, :deleted_at
  end
end
