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
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.unique.clear }
    last_name { Faker::Name.last_name }
    username { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email(domain: 'gmail.com') }

    transient do
      followers { [] }
    end

    after(:create) do |user, evaluator|
      evaluator.followers.each do |follower|
        create(:bond, :following, user: follower, friend: user)
      end
    end
  end
end
