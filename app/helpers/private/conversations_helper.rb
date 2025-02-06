module Private::ConversationsHelper
    # get the opposite user of the conversation 
    def private_conv_recipient(conversation)
        conversation.opposed_user(current_user)
    end
    # if the conversation has unshown messages, show a button to get them
    def load_private_messages(conversation)
        if conversation.messages.count > 0 
        'private/conversations/conversation/messages_list/link_to_previous_messages'
        else
        'shared/empty_partial'
    end 
    def private_message_date_check(message, previous_message)
        if defined?(previous_message) && previous_message.present? 
          # if messages are not created at the same day
          if previous_message.created_at.to_date != message.created_at.to_date
            @message = message
            'private/messages/message/new_date'
          else
            'shared/empty_partial'
          end 
        else
          'shared/empty_partial'
        end 
      end
  end
end
