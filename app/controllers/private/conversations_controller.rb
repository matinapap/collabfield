class Private::ConversationsController < ApplicationController
  before_action :authenticate_user!

  def create
    recipient_id = Post.find(params[:post_id]).user.id
    conversation = Private::Conversation.new(sender_id: current_user.id, 
                                             recipient_id: recipient_id)
    if conversation.save
      Private::Message.create(user_id: current_user.id, 
                              conversation_id: conversation.id, 
                              body: params[:message_body])
      redirect_to request.referer || root_path
    else
      redirect_to request.referer || root_path
    end
  end
end
