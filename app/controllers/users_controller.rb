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
    @user.record.save!
    redirect_to save_another_path(users_path, new_user_path), notice: i18s(:user)
  rescue
    redirect_to new_user_path, alert: i18f(:user)
  end

  def edit
    @user = UserContracts::Base.new(record: user)
  end

  def update
    @user = UserContracts::Update.new(permit_params)
    return render :edit if @user.invalid?
    @user.record.save!
    redirect_to save_another_path(users_path, new_user_path), notice: i18s(:user)
  rescue
    redirect_to edit_user_path(user.id), alert: i18f(:user)
  end

  def destroy
    return redirect_to users_path, notice: i18s(:user) if user.destroy
    redirect_to users_path, alert: i18f(:user)
  end

  private

  def permit_params
    record = params[:id] ? user : User.new
    params.require(:user).permit(:username, :fullname, :password, :admin, group_ids: []).merge(record: record)
  end

  def user
    @object ||= User.find(params[:id])
  end
end
