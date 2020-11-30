class Story < ApplicationRecord
  default_scope { order(created_at: :desc) }
  belongs_to :user

  scope :stories_author, ->(user) { where(user_id: user.id) }
end
