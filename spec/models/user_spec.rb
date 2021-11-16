require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should save user when we have all require fields and requirements' do
    @user =
      User.create(
        first_name: 'Ed',
        last_name: 'Yu',
        email: '123@123.com',
        password: '123456',
        password_confirmation: '123456',
      )
    expect(@user.errors.any?).to eq(false)
  end

  it 'should error when password fields dont match' do
    @user =
      User.create(
        first_name: 'Ed',
        last_name: 'Yu',
        email: '123@123.com',
        password: '12345655',
        password_confirmation: '123456',
      )
    expect(@user.errors.full_messages).to include(
      "Password confirmation doesn't match Password",
    )
  end
  it 'should error when a email is not unique' do
    @user1 =
      User.create(
        first_name: 'Ed',
        last_name: 'Yu',
        email: 'TEST@TEST.com',
        password: '123456',
        password_confirmation: '123456',
      )
    @user2 =
      User.create(
        first_name: 'Joe',
        last_name: 'Bob',
        email: 'test@test.COM',
        password: '123456',
        password_confirmation: '123456',
      )
    expect(@user2.errors.full_messages).to include(
      'Email has already been taken',
    )
  end
  it 'should error when email is not filled' do
    @user =
      User.create(
        first_name: 'Ed',
        last_name: 'Yu',
        email: nil,
        password: '123456',
        password_confirmation: '123456',
      )
    expect(@user.errors.full_messages).to include("Email can't be blank")
  end

  it 'should error when first name is not filled' do
    @user =
      User.create(
        first_name: nil,
        last_name: 'Yu',
        email: '123@123.com',
        password: '123456',
        password_confirmation: '123456',
      )
    expect(@user.errors.full_messages).to include("First name can't be blank")
  end

  it 'should error when last name is not filled' do
    @user =
      User.create(
        first_name: 'Ed',
        last_name: nil,
        email: '123@123.com',
        password: '123456',
        password_confirmation: '123456',
      )
    expect(@user.errors.full_messages).to include("Last name can't be blank")
  end
  it 'should error when password does not meet min length' do
    @user =
      User.create(
        first_name: 'Ed',
        last_name: 'Yu',
        email: '123@123.com',
        password: '123',
        password_confirmation: '123',
      )
    expect(@user.errors.full_messages).to include(
      'Password is too short (minimum is 6 characters)',
    )
  end
end
