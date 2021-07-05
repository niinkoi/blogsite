# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  is_public  :boolean          default(TRUE), not null
#  label      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_categories_on_user_id  (user_id)
#
FactoryBot.define do
  factory :category do
    label { Faker::Lorem.characters(number: 10) }
    user { create(:user) }
    is_public { true }

    trait :private do
      is_public { false }
    end

    trait :without_label do
      label { nil }
    end

  end
end
