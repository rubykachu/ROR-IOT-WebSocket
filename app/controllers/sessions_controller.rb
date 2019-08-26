class SessionsController < ApplicationController
  layout 'session'
  before_action :check_login, only: %i[new create]

  def new
    @user = SessionContracts::Create.new(record: User.new)
  end

  def create
    @user = SessionContracts::Create.new(permit_params)
    return render :new if @user.invalid?

    create_cookie if permit_params[:remember_me].present?
    create_session

    redirect_to root_path, notice: 'Login successfully'
  end

  def destroy
    session.clear
    cookies.delete :app_iot
    redirect_to sign_in_path, notice: 'Logout successfully'
  end

  private

  def permit_params
    params.require(:user).permit(:username, :password, :remember_me)
          .merge(record: User.new)
  end

  def create_session
    session[:app_iot] = { username: permit_params[:username] }
  end

  def create_cookie
    cookies.signed[:app_iot] = { value: SecureRandom.base64(10), expires: Time.current + 3.days }
    user = User.find_by_username(permit_params[:username])
    user.update(remember_digest: cookies[:app_iot])
  end

  def check_login
    redirect_to root_path if logined?
  end
end
