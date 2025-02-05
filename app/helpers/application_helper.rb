require_dependency 'navigation_helper'

module ApplicationHelper
  include NavigationHelper
  include Private::ConversationsHelper
  include PostsHelper
end
