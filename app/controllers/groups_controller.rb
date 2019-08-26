class GroupsController < ApplicationController
  before_action :authenticate
  before_action :devices, only: %i[new create edit update]

  def index
    @groups = Group.order_alphabet
  end

  def new
    @group = GroupContracts::Base.new(record: Group.new)
  end

  def create
    @group = GroupContracts::Base.new(permit_params)
    return render :new if @group.invalid?
    return redirect_to save_another_path(groups_path, new_Group_path), notice: i18s(:group) if @group.record.save
    redirect_to new_group_path, alert: i18f(:group)
  end

  def edit
    @group = GroupContracts::Base.new(record: group)
  end

  def update
    @group = GroupContracts::Base.new(permit_params)
    return render :edit if @group.invalid?
    return redirect_to groups_path, notice: i18s(:group) if @group.record.save
    redirect_to edit_group_path(group.id), alert: i18f(:group)
  end

  def destroy
    return redirect_to groups_path, notice: i18s(:group) if group.destroy
    redirect_to groups_path, alert: i18f(:group)
  end

  private

  def permit_params
    record = params[:id] ? group : Group.new
    params.require(:group).permit(:name, :position, :area_id).merge(record: record)
  end

  def group
    @object ||= Group.find(params[:id])
  end

  def devices
    @devices ||= Device.order_alphabet.includes(:area)
  end
end
