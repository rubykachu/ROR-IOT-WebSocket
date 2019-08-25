class UsersController < ApplicationController
  before_action :authenticate

  def index
    @users = User.order_latest
  end

  def new
    @user = UserContracts::Base.new(record: User.new)
  end

  def create
    @user = UserContracts::Create.new(permit_params)
    return render :new if @user.invalid?
    return redirect_to users_path, notice: I18n.t('user.create.success') if @user.record.save
    redirect_to new_user_path, alert: I18n.t('user.create.fail')
  end

  def edit
    @user = UserContracts::Base.new(record: user)
  end

  def update
    @user = UserContracts::Update.new(permit_params)
    return render :edit if @user.invalid?
    return redirect_to users_path, notice: I18n.t('user.update.success') if @user.record.save
    redirect_to edit_user_path(user.id), alert: I18n.t('user.create.fail')
  end

  private

  def permit_params
    record = params[:id] ? user : User.new
    params.require(:user).permit(:username, :fullname, :password, :admin).merge(record: record)
  end

  def user
    @object ||= User.find(params[:id])
  end
end
