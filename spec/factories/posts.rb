# == Schema Information
#
# Table name: posts
#
#  id                :bigint           not null, primary key
#  content           :text(65535)      not null
#  is_public         :boolean          default(TRUE), not null
#  short_description :string(255)
#  title             :string(255)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  category_id       :bigint           not null
#  thread_id         :bigint
#  user_id           :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id_and_category_id_and_thread_id  (user_id,category_id,thread_id) UNIQUE
#
FactoryBot.define do
  factory :post do
    title { Faker::Lorem.word }
    short_description { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.paragraphs }
    user { create(:user) }
    category { create(:category) }

    trait :with_replies do
      replies { FactoryBot.create_list(:post, 2) }
    end

    trait :without_author do
      user { nil }
    end

    trait :without_category do
      category { nil }
    end

    trait :without_title do
      title { nil }
    end

    trait :without_content do
      content { nil }
    end
  end
end
