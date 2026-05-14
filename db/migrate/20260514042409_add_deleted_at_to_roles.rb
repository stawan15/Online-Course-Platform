class AddDeletedAtToRoles < ActiveRecord::Migration[8.1]
  def change
    add_column :roles, :deleted_at, :datetime
    add_index :roles, :deleted_at
  end
end
