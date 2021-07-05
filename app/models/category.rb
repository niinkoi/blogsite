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
class Category < ApplicationRecord

  validates_presence_of :label, :is_public, :user_id
  validates_uniqueness_of :label

  belongs_to :user
  has_many :posts
end
