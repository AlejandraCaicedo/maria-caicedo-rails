require 'rails_helper'

RSpec.describe Visible do

  # Creating an user to test the module Visible
  current_user = User.first_or_create!( username: 'Maria Caicedo', email: 'maria@mail.com', gender: 'Female', password: '123456')

  let(:article_params) do
    {
      title: 'This is an article',
      body: 'This is the body',
      status: 'public',
      user_id: current_user.id
    }
  end

  describe 'checks different status' do
    context 'status is public or private or archived' do
      it 'if public returns true' do
        # This is a public article
        article = Article.create(article_params)

        expect(article).to be_valid
      end

      it 'if private returns true' do
        # This is a private article, changing the default status to private with merge
        article = Article.create(article_params.merge(status: 'private'))

        expect(article).to be_valid
      end

      it 'if archived returns true' do
        # This is a archived article, changing the default status to archived with merge
        article = Article.create(article_params.merge(status: 'archived'))

        expect(article).to be_valid
      end
    end
  end

  describe '#archived?' do
    context 'if status is archived' do
      it 'returns true' do
        article = Article.create(article_params.merge(status: 'archived'))
        expect(article.archived?).to be_truthy
      end
    end

    context 'if status is not archived' do
      it 'returns false' do
        
        # This is a public article
        article = Article.create(article_params)
        expect(article.archived?).to be_falsy

        # This is a private article, changing the default status to private with merge
        article = Article.create(article_params.merge(status: 'private'))
        expect(article.archived?).to be_falsy
      end
    end
  end

end
