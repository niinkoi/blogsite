# == Schema Information
#
# Table name: bonds
#
#  id         :bigint           not null, primary key
#  state      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friend_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  fk_rails_e0ed660ebe                   (friend_id)
#  index_bonds_on_user_id_and_friend_id  (user_id,friend_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (friend_id => users.id)
#
FactoryBot.define do
  factory :bond do
    trait :following do
      state { Bond::FOLLOWING }
      # user { create(:user) }
      # friend { create(:user) }
    end

    trait :requesting do
      state { Bond::REQUESTING }
    end
  end
end
