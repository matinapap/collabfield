require 'rails_helper'

RSpec.describe Private::ConversationsHelper, type: :helper do
  context '#load_private_messages' do
    let(:conversation) { create(:private_conversation) }

    it "returns load_messages partial's path when there are messages" do
      # Δημιουργία ενός μηνύματος
      create(:private_message, conversation_id: conversation.id)

      # Έλεγχος ότι η μέθοδος επιστρέφει το σωστό partial path
      expect(helper.load_private_messages(conversation)).to eq(
        'private/conversations/conversation/messages_list/link_to_previous_messages'
      )
    end

    it "returns empty partial's path when there are no messages" do
      # Έλεγχος ότι η μέθοδος επιστρέφει το σωστό path όταν δεν υπάρχουν μηνύματα
      expect(helper.load_private_messages(conversation)).to eq(
        'shared/empty_partial'
      )
    end
  end
end
