require 'rails_helper'

RSpec.describe User, type: :model do


  it 'responds to attributes name, email and password (& confirmation)' do
    user = User.new

    expect(user).to respond_to(:name)
    expect(user).to respond_to(:email)
    expect(user).to respond_to(:password)
    expect(user).to respond_to(:password_confirmation)
  end


  it 'has valid factories' do
    user = FactoryGirl.build(:user)

    expect(user).to be_valid
    expect(user.save).to be_truthy
  end


  it 'should validate presence of name, email & password' do
    user  = User.new

    expect(user).to validate_presence_of(:name)
    expect(user).to validate_presence_of(:email)
    expect(user).to validate_presence_of(:password)
  end


  # it 'should validate case-insensitive uniqueness of email' do
  #   user  = User.new

  #   expect(user).to validate_uniqueness_of(:email).case_insensitive
  # end

end
