# spec/models/private/conversation_spec.rb

require 'rails_helper'

RSpec.describe Private::Conversation, type: :model do
  context 'scope #between_users' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:conversation) { create(:private_conversation, sender: user1, recipient: user2) }

    it 'returns a conversation between two users' do
      result = Private::Conversation.between_users(user1.id, user2.id)
      expect(result).to include(conversation)
    end

    it 'does not return a conversation between other users' do
      user3 = create(:user)
      result = Private::Conversation.between_users(user1.id, user3.id)
      expect(result).to be_empty
    end
  end
end
