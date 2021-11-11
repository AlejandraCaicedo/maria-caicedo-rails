require 'rails_helper'

RSpec.describe "Comments", type: :request do

  # Creating an user to test the Comment controller
  current_user = User.first_or_create!( username: 'Maria Caicedo', email: 'maria@mail.com', gender: 'Female', password: '123456')

  # Creating an article to test the Comment controller
  let!(:article) {
    Article.create(
      title: 'This is an article',
      body: 'This is the body',
      status: 'public',
      user_id: current_user.id
    )
  }

  # Creating the valid attibutes to the comment
  let(:valid_attributes) do
    {
      title: 'This is a comment',
      body: 'This is the body',
      status: 'public',
      user_id: current_user.id,
      article_id: article.id
    }
  end

  describe 'GET /new' do
    it 'renders a succesful response' do
      get new_article_comment_url(article)
      expect(response).to render_template(:new)
      expect(response).to be_successful
    end
  end

end
