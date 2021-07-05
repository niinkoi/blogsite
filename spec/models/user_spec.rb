# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      not null
#  encrypted_password     :string(255)      default(""), not null
#  first_name             :string(255)      not null
#  last_name              :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  username               :string(255)      not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#valid?' do
    context 'with valid email' do
      it 'is valid when email is unique' do
        users = create_list(:user, 2)
        expect(users.second.email).not_to eq users.first.email
        expect(users.second.valid?).to be true
      end
    end

    context 'with invalid email' do
      it 'is invalid if the email is taken' do
        another_user = create(:user, email: 'nguyen@gmail.com')
        user = User.new
        user.email = another_user.email
        expect(user.valid?).to be false
      end

      it 'is invalid if the email looks bogus' do
        user = create(:user)
        expect(user).to be_valid

        user.email = ''
        expect(user).to be_invalid

        user.email = 'foo.bar'
        expect(user).to be_invalid

        user.email = 'foo.bar#example.com'
        expect(user).to be_invalid

        user.email = 'f.o.o.b.a.r@example.com'
        expect(user).to be_valid

        user.email = 'foo+bar@example.com'
        expect(user).to be_valid

        user.email = 'foo.bar@sub.example.co.id'
        expect(user).to be_valid
      end
    end

    context 'with valid username' do
      let(:user) { create(:user) }
      it 'is valid user' do
        expect(user.valid?).to be true
      end
    end

    context 'with invalid username' do
      let(:user) { create(:user) }

      it 'is invalid if username is taken' do
        another_user = create(:user)
        another_user.username = user.username
        expect(another_user.valid?).to be false
      end

      it 'is invalid if username is blank' do
        user.username = ''
        expect(user.valid?).to be false

        user.username = nil
        expect(user.valid?).to be false
      end
    end
  end

  context 'with invalid first name' do
    it "is invalid if user's first name is blank" do
      user = create(:user)
      user.first_name = ''
      expect(user.valid?).to be false

      user.first_name = nil
      expect(user.valid?).to be false
    end
  end
end

describe '#followings' do
  it "can list all of the user's followings" do
    user = create(:user)
    friends = create_list(:user, 3)

    friends.each { |friend| create(:bond, :following, user: user, friend: friend) }
    Bond.third.state = Bond::REQUESTING
    expect(user.followings) =~ friends[0..1]
    expect(user.follow_requests) =~ friends[2]
  end
end

describe '#followers' do
  context "can list all of the user's followers" do
    before do
      @users = create_list(:user, 2) # List of example users
      @followers = create_list(:user, 4) # List of example followers
      # Making 2 followers for the first user
      @followers[0..1].each { |follower| create(:bond, :following, user: follower, friend: @users.first) }

      # Create one follower and one is requesting to be follower for the second user
      create(:bond, :following, user: @followers[2], friend: @users.second)
      create(:bond, :requesting, user: @followers[3], friend: @users.second)
    end

    it 'should have exactly amount of followers for each user' do
      expect(@users.first.followers.count).eql? 2
      expect(@users.second.followers.count).eql? 1
    end

    it 'should have correct followers for each user' do
      expect(@users.first.followers) =~ @followers[0..1]
      expect(@users.second.followers) =~ @followers[2]
    end
  end
end

describe '#save' do
  it 'capitalized the name correctly' do
    user = create(:user)

    user.first_name = 'kHoi'
    user.last_name = 'nGuYen'
    user.save

    expect(user.first_name).eql? 'Khoi'
    expect(user.last_name).eql? 'Nguyen'
  end

end
