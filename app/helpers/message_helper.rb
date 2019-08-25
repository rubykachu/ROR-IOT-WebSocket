module MessageHelper
  def error_message_inline(object, field, klass = {})
    message = object.errors.messages[field][0]
    return if message.nil?
    content_tag :div, message, class: "error-invalid #{klass[:class]}"
  end

  def print_flash_message
    return if flash.keys.blank?
    meta = meta_alert
    content_tag :div, class: "alert alert-#{meta[:klass]} alert-dismissible fade show", role: 'alert' do
      concat content_tag :strong, "#{meta[:text]}! "
      concat meta[:message]
      concat(
        button_tag(
          '<span aria-hidden="true">&times;</span>'.html_safe,
          class: 'close', data: { dismiss: 'alert' }, aria: { label: 'Close' }
        )
      )
    end
  end

  private

  def meta_alert
    return { klass: 'success', text: 'Success', message: flash[:notice] } if flash[:notice].present?
    { klass: 'danger', text: 'Error', message: flash[:alert] } if flash[:alert].present?
  end
end
