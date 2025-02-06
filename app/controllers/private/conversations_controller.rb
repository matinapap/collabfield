class Private::ConversationsController < ApplicationController
    def conversation_exist?
        Private::Conversation.between_users(current_user.id, @post.user.id).present?
    end

  def create
    recipient_id = Post.find(params[:post_id]).user.id
    conversation = Private::Conversation.new(sender_id: current_user.id, 
                                            recipient_id: recipient_id)
    if conversation.save
      Private::Message.create(user_id: recipient_id, 
                              conversation_id: conversation.id, 
                              body: params[:message_body])
      redirect_to post_path(params[:post_id]) 
    else
      # Αν υπάρχει σφάλμα, κάνουμε refresh και με alert
      head :unprocessable_entity
    end
  end
end
