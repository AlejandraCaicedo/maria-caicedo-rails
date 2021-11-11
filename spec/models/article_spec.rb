require 'rails_helper'

RSpec.describe Article, type: :model do

  # Creating an user to test the Article model
  current_user = User.first_or_create!( username: 'Maria Caicedo', email: 'maria@mail.com', gender: 'Female', password: '123456')

  # Creating an article
  subject {
    described_class.new(
      title: 'This is an article',
      body: 'This is the body',
      status: 'public',
      user_id: current_user.id
    )
  }

  describe 'title' do
    it 'must be present and cannot be empty' do
      expect(subject.title.blank?).to be_falsy
    end
  end

  describe 'body' do
    it 'must be present and cannot be empty' do
      expect(subject.body.blank?).to be_falsy
    end

    it 'must have minimun 10 characters' do
      # Is not possible to compare directly strings with be_valid method

      subject.body = 'This is the body'
      expect(subject).to be_valid

      subject.body = 'Body'
      expect(subject).not_to be_valid
    end
  end

  describe 'status' do
    it 'must be present and cannot be empty' do
      expect(subject.status.blank?).to be_falsy
    end
  end

  describe 'user_id' do
    it 'must be present' do
      expect(subject.user_id.blank?).to be_falsy
    end

    it 'must represent an existent user' do
      # Is not possible to compare directly intenger with be_valid method
      subject.user_id = 1
      expect(subject).to be_valid

      subject.user_id = 5
      expect(subject).not_to be_valid
    end
  end

end
