# app/models/private/conversation.rb

class Private::Conversation < ApplicationRecord
    # Μηνύματα που ανήκουν σε αυτή τη συνομιλία
    has_many :messages, 
             class_name: "Private::Message", 
             foreign_key: :conversation_id
    
    # Ο χρήστης που ξεκινά τη συνομιλία
    belongs_to :sender, 
               foreign_key: :sender_id, 
               class_name: 'User'
  
    # Ο χρήστης που είναι ο παραλήπτης
    belongs_to :recipient, 
               foreign_key: :recipient_id, 
               class_name: 'User'
  
    # Scope για να ελέγξει αν υπάρχει συνομιλία μεταξύ των δύο χρηστών
    scope :between_users, -> (user1_id, user2_id) do
      where(sender_id: user1_id, recipient_id: user2_id).or(
        where(sender_id: user2_id, recipient_id: user1_id)
      )
    end
  end
  