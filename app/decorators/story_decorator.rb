class StoryDecorator < Draper::Decorator
  include ActionView::Helpers::DateHelper
  delegate_all
  decorates :story
  decorates_association :tags

  def last_update
    object.updated_at.strftime('%m/%d/%y - %I:%M %p') unless object.updated_at.nil?
  end
end
