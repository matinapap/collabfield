class AddUserIdToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :user_id, :bigint
  end
end
