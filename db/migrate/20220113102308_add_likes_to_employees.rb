class AddLikesToEmployees < ActiveRecord::Migration[7.0]
  def up
    add_column :employees, :likes, :integer, default: 0, null: false
  end

  def down
    remove_column :employees, :like
  end
end
