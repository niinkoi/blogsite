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
require 'rails_helper'

RSpec.describe Bond, type: :model do

  describe '#valid?' do
    context 'should validate the state correctly' do

      before do
        @bond = Bond.new(
          user: build(:user),
          friend: build(:user)
        )
      end

      it 'should be invalid if the state is invalid' do
        expect(@bond.valid?).to be false
      end

      it 'should be valid if the state is valid' do
        Bond::STATES.each do |state|
          @bond.state = state
          expect(@bond.valid?).to be true
        end
      end
    end
  end

  describe '#save' do
    context 'when complete data is given' do
      before do
        @user = create(:user)
        @friend = create(:user)
        @bond = create(:bond, :requesting, user: @user, friend: @friend)
      end

      it 'should be persisted' do
        expect(@bond).to be_persisted
      end

      it 'should have the correct user' do
        expect(@bond.user).eql? @user
      end

      it 'should have the correct friend' do
        expect(@bond.friend).eql? @friend
      end
    end
  end

end
