require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /index" do
    pending "add some examples (or delete) #{__FILE__}"
  end

  context 'Scopes' do
    it 'default_scope orders by descending created_at' do
      first_post = create(:post)
      second_post = create(:post)
      expect(Post.all).to eq [second_post, first_post]
  end
end
