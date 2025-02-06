class CreatePrivateMessages < ActiveRecord::Migration[6.0]
  def change
    unless table_exists?(:private_messages)
      create_table :private_messages do |t|
        t.references :conversation, null: false, foreign_key: { to_table: :private_conversations }
        t.references :sender, null: false, foreign_key: { to_table: :users }
        t.references :recipient, null: false, foreign_key: { to_table: :users }
        t.text :content
        t.timestamps
      end
    end
  end
end
