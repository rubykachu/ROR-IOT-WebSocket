class GroupsController < ApplicationController
  before_action :authenticate
  before_action :devices, only: %i[new create edit update]

  def index
    @groups = Group.order_alphabet.common_includes
  end

  def new
    @group = GroupContracts::Base.new(record: Group.new)
  end

  def create
    @group = GroupContracts::Base.new(permit_params)
    return render :new if @group.invalid?
    Group.transaction do
      @group.record.save!
      insert_all_devices_groups!(permit_params[:device_ids])
    end
    redirect_to save_another_path(groups_path, new_group_path), notice: i18s(:group)
  rescue
    redirect_to new_group_path, alert: i18f(:group)
  end

  def edit
    @group = GroupContracts::Base.new(record: group)
    @device_ids = @group.record.devices_groups.pluck(:device_id)
  end

  def update
    @group = GroupContracts::Base.new(permit_params)
    return render :edit if @group.invalid?
    Group.transaction do
      @group.record.save!
      old_id    = @group.record.devices_groups.pluck(:device_id)
      new_id    = @group.device_ids
      insert_id = new_id - old_id
      remove_id = old_id - new_id

      destroy_all_devices_groups!(remove_id)
      insert_all_devices_groups!(insert_id)
    end
    redirect_to save_another_path(groups_path, edit_group_path(@group.record)), notice: i18s(:group)
  rescue
    redirect_to edit_group_path(group.id), alert: i18f(:group)
  end

  def destroy
    return redirect_to groups_path, notice: i18s(:group) if group.destroy
    redirect_to groups_path, alert: i18f(:group)
  end

  private

  def permit_params
    record = params[:id] ? group : Group.new
    params.require(:group).permit(:name, device_ids: []).merge(record: record)
  end

  def group
    @object ||= Group.find(params[:id])
  end

  def devices
    @devices ||= Device.common_order.includes(:area)
  end

  def insert_all_devices_groups!(device_ids)
    device_ids.each { |device_id| @group.record.devices_groups.create!(device_id: device_id) }
  end

  def destroy_all_devices_groups!(device_ids)
    @group.record.devices_groups.where(device_id: device_ids).destroy_all
  end
end
