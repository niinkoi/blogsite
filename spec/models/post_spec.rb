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
require 'rails_helper'

RSpec.describe Post, type: :model do

  describe '#valid?' do
    context 'with valid attributes' do
      before do
        @user = create(:user)
        @category = create(:category)
        @post = create(:post, user: @user)
      end

      it 'should be valid when created post is valid' do
        expect(@post.valid?).to be true
      end

      it 'should have correct author' do
        expect(@post.user).eql? @user
      end

      it 'should have correct category' do
        expect(@post.category).eql? @category
      end
    end

    context 'with invalid attributes' do
      it 'should be invalid when the post do not have title' do
        post = build(:post, :without_title)
        expect(post.save).to be false
      end

      it 'should be invalid when the post do not have its content' do
        post = build(:post, :without_content)
        expect(post.save).to be false
      end
    end
  end

  describe '#save' do
    context 'when given post is missing author field' do
      before { @post = build(:post, :without_author) }

      it 'should not be persisted' do
        @post.save
        expect(@post).not_to be_persisted
      end

      it 'should belong to a user' do
        @post.user = create(:user)
        @post.save
        expect(@post).to be_persisted
      end

      context 'when given post is missing category field' do
        before { @post = build(:post, :without_category) }

        it 'should not be persisted' do
          @post.save
          expect(@post).not_to be_persisted
        end

        it 'should belong to a category' do
          @post.category = create(:category)
          @post.save
          expect(@post).to be_persisted
        end
      end
    end

    context 'with complete data is given' do
      before { @post = create(:post, :with_replies) }
      it 'should contain other posts' do
        expect(@post.replies.count).eql? 2
      end
    end
  end
end
