class AddDeletedAtToLessons < ActiveRecord::Migration[8.1]
  def change
    add_column :lessons, :deleted_at, :datetime
    add_index :lessons, :deleted_at
  end
end
