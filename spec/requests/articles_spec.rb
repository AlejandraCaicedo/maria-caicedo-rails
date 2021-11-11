require 'rails_helper'

RSpec.describe "Articles", type: :request do

  include Devise::Test::IntegrationHelpers

  # Creating an user to test the Article controller
  current_user = User.first_or_create!( username: 'Maria Caicedo', email: 'maria@mail.com', gender: 'Female', password: '123456')

  let(:valid_attributes) do
    {
      title: 'This is an article',
      body: 'This is the body',
      status: 'public',
      user_id: current_user.id
    }
  end

  # article = Article.create(valid_attributes)
  let(:article) { Article.create(valid_attributes) }

  # Creating a new user session with devise
  before do
    sign_in current_user
  end

  describe 'GET /index' do
    it 'shows all saved articles' do

      get articles_url

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    it 'shows a specific article' do

      get article_url(article)

      expect(response).to render_template(:show)

      # Checks if the responde contains all needed
      expect(response.body).to include(article.title)
      expect(response.body).to include(article.body)
    end
  end

  describe 'GET /new' do
    context 'if user is logged' do
      it 'renders template create a new article' do

        get new_article_url

        # code 200
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)        
      end
    end
  end

  describe 'POST /create' do
    context 'if are valid article attributes' do
      it 'article is created, and redirects to article page' do

        article_params = {
          article: {
            title: valid_attributes[:title],
            body: valid_attributes[:body],
            status: valid_attributes[:status]
          }
        }

        # Article's count increment by 1
        expect { post articles_url, params: article_params }.to change { Article.count }.by(1)

        # code 302
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(article_url(assigns(:article)))
      end
    end

    context 'if are invalid article attributes' do
      it 'article is not created, and renders new article page' do

        bad_article_params = {
          article: {
            body: valid_attributes[:body],
            status: valid_attributes[:status]
          }
        }

        # Article's count is not increment by 1
        expect { post articles_url, params: bad_article_params }.not_to(change { Article.count })
        
        # code 200
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET /edit' do
    context 'if user is logged' do
      it 'renders edit article page' do
        get edit_article_url(article)

        # code 200
        expect(response).to have_http_status(:ok)
        
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET /update' do

    let(:new_article_params) do
      {
        article: {
          title: 'This is a new title',
          body: 'New body',
          status: 'public'
        }
      }
    end

    context 'if user is logged' do
      it 'update article' do
        put article_url(article), params: new_article_params

        # code 200
        expect(response).to have_http_status(:ok)

        expect(response.body).to include('This is a new title')
        expect(response.body).to include('New body')
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'if user is logged' do
      it 'destroy article and redirects to articles list' do

        # Checks if article exits
        get article_url(article)
        expect(response).to render_template(:show)

        expect { delete article_url(article) }.to change { Article.count }.by(-1)
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
