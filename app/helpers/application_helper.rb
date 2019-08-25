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
end
