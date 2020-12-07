class Story < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: %i[slugged history]
  default_scope { order(created_at: :desc) }
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy
  validates :title, presence: true

  scope :stories_author, ->(user) { where(user_id: user.id) }
  scope :search, ->(title) { where('title like ?', "%#{title}%") }

  def tag_list
    tags.join(', ')
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(',').collect { |s| s.strip.downcase }.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end
end
