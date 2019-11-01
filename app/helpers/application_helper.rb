module ApplicationHelper
  def present(model, presenter_class = nil)
    klass = presenter_class || "#{model.class}Presenter".constantize
    presenter = klass.new(model, self)
    yield(presenter) if block_given?
  end

  def logined?
    current_user.present?
  end

  def current_user
    return @current_user if @current_user
    if session[:app_iot]
      return @current_user = User.find_by(username: session[:app_iot]['username'])
    end

    if cookies[:app_iot]
      @current_user = User.find_by(remember_digest: cookies[:app_iot])
    end
  end

  def hello_user
    name = current_user&.fullname.presence || current_user.username
    link_to "Hi, #{name}", nil, class: 'nav-link'
  end

  def save_another_path(left_path, continue_path)
    return left_path if params[:save_another].blank?
    continue_path
  end

  def save_another_tag
    button_tag t('save_another'), value: :save_another, name: :save_another, type: :submit, class: 'btn btn-info mr-2'
  end

  def edit_link(path, klass = {})
    klass = klass[:class].presence || 'text-warning pr-3'
    link_to 'Edit', path, class: klass
  end

  def delete_link(path, klass = {})
    klass = klass[:class].presence || 'text-danger'
    link_to 'Destroy', path, class: klass, method: :delete, data: { confirm: t('confirm') }
  end

  # Success: Lookup lazy I18 for controller
  def i18s(subject)
    t(".success", subject: subject)
  end

  # Fail: Lookup lazy I18 for controller
  def i18f(subject)
    t(".fail", subject: subject)
  end

  def count_pluralize(count, string)
    "#{count} #{string.to_s.pluralize(count)}"
  end
end
