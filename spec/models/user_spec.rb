require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is invalid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to be_present
    end

    it 'is invalid with a duplicate email' do
      create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to be_present
    end

    it 'is invalid with an invalid email format' do
      user = build(:user, email: 'invalid-email')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to be_present
    end

    it 'is invalid without a password' do
      user = build(:user, password: nil, password_confirmation: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to be_present
    end

    it 'is invalid with a password shorter than minimum length' do
      user = build(:user, password: '12345', password_confirmation: '12345')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to be_present
    end
  end

  describe 'Devise modules' do
    it 'responds to database_authenticatable methods' do
      user = create(:user)
      expect(user).to respond_to(:valid_password?)
    end

    it 'responds to registerable methods' do
      user = build(:user)
      expect(user).to respond_to(:email)
    end

    it 'responds to recoverable methods' do
      user = create(:user)
      expect(user).to respond_to(:reset_password_token)
    end

    it 'responds to rememberable methods' do
      user = create(:user)
      expect(user).to respond_to(:remember_me)
    end
  end
end
