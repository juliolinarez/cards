require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:title).is_at_least(3).is_at_most(255) }
    it { should validate_length_of(:content).is_at_least(10) }
  end

  describe 'associations' do
    # Add associations tests as needed
    # For example:
    # it { should belong_to(:user) }
  end

  describe 'factory' do
    it 'creates a valid post' do
      post = create(:post)
      expect(post).to be_valid
    end

    it 'creates a valid post with specific data trait' do
      post = create(:post, :with_specific_data)
      expect(post).to be_valid
      expect(post.title).to eq('Sample Post Title')
    end
  end

  describe 'instance methods' do
    let(:post) { create(:post) }

    it 'has a title and content' do
      expect(post.title).to be_present
      expect(post.content).to be_present
    end
  end

  describe 'invalid posts' do
    it 'is invalid without a title' do
      post = build(:post, title: nil)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without content' do
      post = build(:post, content: nil)
      expect(post).not_to be_valid
      expect(post.errors[:content]).to include("can't be blank")
    end

    it 'is invalid with a title that is too short' do
      post = build(:post, title: 'Hi')
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include('is too short (minimum is 3 characters)')
    end

    it 'is invalid with content that is too short' do
      post = build(:post, content: 'Short')
      expect(post).not_to be_valid
      expect(post.errors[:content]).to include('is too short (minimum is 10 characters)')
    end
  end
end
