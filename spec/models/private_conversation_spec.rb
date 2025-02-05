require 'rails_helper'

RSpec.describe Private::Conversation, type: :model do
  context 'Methods' do
    it 'gets an opposed user of the conversation' do
      user1 = create(:user)
      user2 = create(:user)
      conversation = create(:private_conversation,
                             recipient_id: user1.id,
                             sender_id: user2.id)
      opposed_user = conversation.opposed_user(user1)
      expect(opposed_user).to eq user2
    end
  end
end
