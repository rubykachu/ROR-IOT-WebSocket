class DevicePresenter < BasePresenter
  def created_at_human
    h.time_ago_in_words(model.created_at)
  end
end
