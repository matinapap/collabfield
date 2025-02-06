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
      Rails.logger.debug("Conversation created with ID: #{conversation.id}")
      redirect_to request.referer || root_path
    else
      Rails.logger.debug("Failed to create conversation")
      redirect_to request.referer || root_path
    end
  end

  def close
    @conversation_id = params[:id].to_i
    session[:private_conversations].delete(@conversation_id)
  
    respond_to do |format|
      format.js
    end
  end

  def close_conversation
    # Διαγραφή του conversation_id από την session
    session[:private_conversations].delete(params[:id].to_i)

    # Ανάκληση του partial
    respond_to do |format|
      format.js { render partial: 'private/conversations/close_conversation' }
    end
  end


  def opened_conversations_windows
    if user_signed_in?
      session[:private_conversations] ||= []
      @private_conversations_windows = Private::Conversation.includes(:recipient, :messages)
                                        .where(id: session[:private_conversations])
    else
      @private_conversations_windows = []
    end
  end


  def open
    @conversation = Private::Conversation.find(params[:id])
    add_to_conversations unless already_added?
    respond_to do |format|
      format.js { render partial: 'private/conversations/open' }
    end
  end

  private

  def add_to_conversations
    session[:private_conversations] ||= []
    session[:private_conversations] << @conversation.id
    Rails.logger.debug("Added to session: #{session[:private_conversations]}")
  end
  
  
  def already_added?
    session[:private_conversations].include?(@conversation.id)
  end
end
