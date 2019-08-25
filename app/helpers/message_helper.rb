module MessageHelper
  def error_message_inline(object, field, klass)
    message = object.errors.messages[field][0]
    return if message.nil?
    content_tag :div, message, class: "error-invalid #{klass[:class]}"
  end
end
