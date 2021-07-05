# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string(255)      not null
#  first_name :string(255)      not null
#  last_name  :string(255)
#  username   :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates_uniqueness_of :email, :username
  validates_presence_of :email, :username, :first_name
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP, messages: 'must be a valid format of email'

  before_save :ensure_proper_name

  has_many :bonds
  has_many :categories
  has_many :posts

  has_many :followings,
           -> { Bond.following },
           through: :bonds,
           source: :friend

  has_many :follow_requests,
           -> { Bond.requesting },
           through: :bonds,
           source: :friend

  has_many :inward_bonds,
           class_name: 'Bond',
           foreign_key: :friend_id

  has_many :followers,
           -> { Bond.following },
           through: :inward_bonds,
           source: :user

  private

  def ensure_proper_name
    self.first_name = first_name.capitalize
    self.last_name = last_name.capitalize
  end
end
