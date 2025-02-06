class Private::Message < ApplicationRecord
    self.table_name = 'private_messages'

    belongs_to :conversation, 
             class_name: 'Private::Conversation',
             foreign_key: :conversation_id

  # Ο χρήστης που έστειλε το μήνυμα
  belongs_to :sender, 
             foreign_key: :sender_id, 
             class_name: 'User'

  # Ο χρήστης που παραλαμβάνει το μήνυμα
  belongs_to :recipient, 
             foreign_key: :recipient_id, 
             class_name: 'User'
  end