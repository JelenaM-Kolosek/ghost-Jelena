class UserDecorator < Draper::Decorator
  delegate_all
  decorates :user

  def image
    if object.image.present?
      h.image_tag user.image_url, size: '200x200', class: 'avatarimg'
    else
      h.image_tag 'avatar.png', size: '200x200', class: 'avatarimg'
    end
  end
end
