class Story < ApplicationRecord
  belongs_to :user

  scope :stories_desc, -> { order(created_at: :desc) }
  scope :stories_desc_author, ->(user) { where(user_id: user.id).order(created_at: :desc) }
end
