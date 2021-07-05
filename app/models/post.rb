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
class Post < ApplicationRecord

  validates_presence_of :title, :user_id, :category_id, :content

  belongs_to :user
  belongs_to :category
  belongs_to :thread, class_name: 'Post', optional: true

  has_many :replies, class_name: 'Post', foreign_key: :thread_id

  scope :not_reply, -> { where(thread_id: nil) }
  scope :of, lambda { |username|
    joins(:user).where(users: { username: username })
  }

end
