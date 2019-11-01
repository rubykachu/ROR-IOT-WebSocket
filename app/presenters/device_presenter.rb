class DevicePresenter < BasePresenter
  delegate :name, to: :area, prefix: true, allow_nil: true

  def created_at_human
    h.time_ago_in_words(model.created_at)
  end
end
