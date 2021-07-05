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
require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#valid' do
    context 'with valid attributes' do
      before { @category = create(:category, label: 'Label') }

      it 'should be valid when label is not blank' do
        expect(@category.save).to be true
      end

      it 'should return exactly given label' do
        expect(@category.label).eql? 'Label'
      end
    end

    context 'with invalid attributes' do
      before { @category = create(:category) }

      it 'should be invalid when label is nil' do
        @category.label = nil
        expect(@category.save).to be false
      end

      it 'should be invalid when label is blank' do
        @category.label = ''
        expect(@category.save).to be false
      end

      it 'should be invalid when label is taken' do
        another_category = create(:category)
        another_category.label = @category.label
        expect(another_category.save).to be false
      end
    end
  end

  describe '#save' do
    context 'when complete data is given' do
      before do
        @user = create(:user)
        @category = create(:category, user: @user)
      end

      it 'should be persisted' do
        expect(@category).to be_persisted
      end

      it 'should have the correct author' do
        expect(@category.user).eql? @user
      end
    end
  end
end
