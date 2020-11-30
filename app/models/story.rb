class Story < ApplicationRecord
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings

  scope :stories_desc, -> { order(created_at: :desc) }
  scope :stories_desc_author, ->(user) { where(user_id: user.id).order(created_at: :desc) }

  def tag_list
    tags.join(', ')
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(',').collect { |s| s.strip.downcase }.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end
end
