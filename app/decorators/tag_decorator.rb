class TagDecorator < Draper::Decorator
  delegate_all
  decorates :tag

  def tag_name
    '#' + object.name
  end
end
