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
class Bond < ApplicationRecord
  STATES = [
    REQUESTING = 'requesting'.freeze,
    FOLLOWING = 'following'.freeze,
    BLOCKING = 'blocking'.freeze
  ].freeze

  enum state: {
    requesting: REQUESTING,
    following: FOLLOWING,
    blocking: BLOCKING
  }

  validates_presence_of :state

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :following, -> { where(state: FOLLOWING) }
  scope :requesting, -> { where(state: REQUESTING) }
  scope :blocking, -> { where(state: BLOCKING) }
end
