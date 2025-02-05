class Private::Conversation < ApplicationRecord
    belongs_to :sender, class_name: 'User'
    belongs_to :recipient, class_name: 'User'
    has_many :private_messages, dependent: :destroy
  
    scope :between_users, -> (user1_id, user2_id) do
      where(sender_id: user1_id, recipient_id: user2_id)
        .or(where(sender_id: user2_id, recipient_id: user1_id))
    end

    def opposed_user(user)
      user == recipient ? sender : recipient
    end
  end
  