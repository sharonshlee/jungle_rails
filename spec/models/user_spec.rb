require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validates password and password_confirmation fields' do
    it 'password should match password confirmation' do
      @user = User.new
      @user.password = '123'
      @user.password_confirmation = '123'
      
      expect(@user.password).to eq(@user.password_confirmation)
    end

    it 'password should not match password confirmation' do
      @user = User.new
      @user.password = '123'
      @user.password_confirmation = '234'
      
      expect(@user.password).not_to eq(@user.password_confirmation)
    end

    it 'password must be presence' do
      @user = User.new
      @user.password = '123'
      expect(@user.password).to be_present
    end

    it 'password confirmation must be presence' do
      @user = User.new
      @user.password_confirmation = '234'
      expect(@user.password_confirmation).to be_present
    end
  end

  describe 'Validates emails' do
    it 'must be unique and not case sensitive' do
      @user = User.new(email: "user@email.COM")
      @user1 = User.new(email: "user@email.com")
      expect(@user1.valid?).to be false
    end

    it "must be presence" do
      @user = User.new(email: nil)
      expect(@user.valid?).to be false
    end
  end

  describe 'Validates name' do
    it 'name must be presence' do
      @user = User.new(name: nil)
      expect(@user.valid?).to be false
    end
  end

  describe 'validates password minimum length' do
    it 'less than minimum length when a user account is being created' do
      @user = User.new
      @user.password = '123'
      
      expect(@user.valid?).to be false
    end

    it 'have a minimum length when a user account is being created' do
      @user = User.new
      @user.password = '12345678'
      @user.valid?
      expect(@user.errors[:password]).to be_empty
    end
  end

  describe '.authenticate_with_credentials' do
    #  need mentor's help
    #  need mentor's help
    #  need mentor's help
    #  need mentor's help
    it 'return user when authenticate successful', :focus do
      @user = User.new(name: 'test', email: '123@gmail.com', password: '11111111')
      @user1 = @user.authenticate_with_credentials(@user.email, @user.password)
      expect(@user1.valid?).to be true
    end

    it 'return nil if fail to authenticate', :focus do
      @user = User.new(name: 'test', email: '123@gmail.com', password: '11111111')
      @user1 = @user.authenticate_with_credentials(@user.email, @user.password)
      expect(@user1.valid?).to be eq(nil)
    end

    it 'email should be trimmed', :focus do
      @user = User.new(name: 'test', email: ' 123@gmail.com ', password: '11111111')
      @user1 = @user.authenticate_with_credentials(@user.email, @user.password)
      expect(@user).to be eq(@user1)
    end

    it 'email should be lowercase', :focus do
      @user = User.new(name: 'test', email: '123@GMAIL.com', password: '11111111')
      @user1 = @user.authenticate_with_credentials(@user.email, @user.password)
      expect(@user).to be eq(@user1)
    end
  end

end
