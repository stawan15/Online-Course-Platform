class AddDeletedAtToCourses < ActiveRecord::Migration[8.1]
  def change
    add_column :courses, :deleted_at, :datetime
    add_index :courses, :deleted_at
  end
end
