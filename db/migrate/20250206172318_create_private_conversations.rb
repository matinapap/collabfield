class CreatePrivateConversations < ActiveRecord::Migration[8.0]
  def change
    unless table_exists?(:private_conversations)
      create_table :private_conversations do |t|
        t.references :sender, null: false, foreign_key: { to_table: :users }
        t.references :recipient, null: false, foreign_key: { to_table: :users }
        t.timestamps
      end
    end
  end
end
