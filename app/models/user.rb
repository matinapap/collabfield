class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook, :twitter]
  has_many :posts, dependent: :destroy
   # Συνομιλίες του χρήστη
   has_many :private_conversations, 
   foreign_key: :sender_id, 
   class_name: 'Private::Conversation'

  # Μηνύματα του χρήστη (ως sender ή recipient)
  has_many :private_messages, class_name: 'Private::Message'
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
