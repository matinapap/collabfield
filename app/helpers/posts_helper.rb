module PostsHelper
    def all_categories_button_partial_path
        if params[:category].blank?
          'posts/branch/categories/all_selected'
        else
          'posts/branch/categories/all_not_selected'
        end
      end
      

    def no_posts_partial_path(posts = [])
         posts.empty? ? 'posts/branch/no_posts' : 'shared/empty_partial'
    end

    def contact_user_partial_path
      if user_signed_in?
        'posts/show/contact_user'
      else
        'posts/show/login_required' 
      end
    end

    def leave_message_partial_path
      logger.debug "@message_has_been_sent: #{@message_has_been_sent}"
      if @message_has_been_sent
        'posts/show/contact_user/already_in_touch'
      else
        'posts/show/contact_user/message_form'
      end
    end    

    def create_new_post_partial_path
        if user_signed_in?
          'posts/branch/create_new_post/signed_in'
        else
          'posts/branch/create_new_post/not_signed_in'
        end
    end

    def post_format_partial_path
      if current_page?(root_path)
        'posts/post/home_page'
      else
        'posts/post/branch_page'
      end
    end

    def send_message
      @message = Message.new(message_params)
      if @message.save
        @message_has_been_sent = true
      else
        @message_has_been_sent = false
        render :new
      end
    end
    
    
      
    def category_field_partial_path
      if params[:category].present?
        'posts/branch/search_form/category_field'
      else
        'shared/empty_partial'
      end
    end
  end
  