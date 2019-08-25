module ApplicationHelper
  def logined?
    session[:app_iot].present? || cookies[:app_iot].present?
  end

  def current_user
    return @current_user if @current_user
    if session[:app_iot]
      return @current_user = User.find_by(username: session[:app_iot]['username'])
    end

    if cookies[:app_iot]
      @current_user = User.find_by(cookie_digest: cookies[:app_iot])
    end
  end

  def hello_user
    name = current_user.fullname.presence || current_user.username
    link_to "Hi, #{name}", nil, class: 'nav-link'
  end

  def save_another_path(left_path, continue_path)
    return left_path if params[:save_another].blank?
    continue_path
  end

  def save_another_tag
    button_tag t('save_another'), value: :save_another, name: :save_another, type: :submit, class: 'btn btn-info mr-2'
  end
end
