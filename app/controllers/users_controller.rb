class UsersController < ApplicationController
  before_action :authenticate

  def index
    @users = User.all
  end

  def new
    @user = UserContracts::Create.new(record: User.new)
  end

  def create
    @user = UserContracts::Create.new(permit_params)
    return render :new if @user.invalid?
    return redirect_to users_path, notice: I18n.t('users.create.success') if @user.record.save
    redirect_to new_user_path, alert: I18n.t('users.create.fail')
  end

  def show
  end

  private

  def permit_params
    params.require(:user).permit(:username, :fullname, :password, :admin).merge(record: User.new)
  end
end
