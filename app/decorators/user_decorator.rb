class UserDecorator < Draper::Decorator
  include ActionView::Helpers::DateHelper
  delegate_all
  decorates :user

  def last_sign_in
    object.last_sign_in_at.strftime('%m/%d/%y - %I:%M %p') unless object.last_sign_in_at.nil?
  end

  def distance_of_time
    distance_of_time_in_words((object.invitation_sent_at + 7.days), Time.now)
  end
end
