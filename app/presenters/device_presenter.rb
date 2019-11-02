class DevicePresenter < ApplicationPresenter
  presenter :device
  delegate :name, to: :area, prefix: true, allow_nil: true
  delegate :count, to: :users, prefix: true

  def created_at_human
    return nil unless device.created_at?
    h.time_ago_in_words(device.created_at)
  end

  def label_assignment(&block)
    if device.users.blank?
      h.content_tag :span, 'Unused', class: 'badge badge-warning'
    else
      block.call
    end
  end
end
