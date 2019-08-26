class DevicesController < ApplicationController
  before_action :authenticate
  before_action :areas, only: %i[new create edit update]

  def index
    @devices = Device.order_alphabet
  end

  def new
    @device = DeviceContracts::Base.new(record: Device.new)
  end

  def create
    @device = DeviceContracts::Base.new(permit_params)
    return render :new if @device.invalid?
    return redirect_to save_another_path(devices_path, new_device_path), notice: i18s(:device) if @device.record.save
    redirect_to new_device_path, alert: i18f(:device)
  end

  def edit
    @device = DeviceContracts::Base.new(record: device)
  end

  def update
    @device = DeviceContracts::Base.new(permit_params)
    return render :edit if @device.invalid?
    return redirect_to devices_path, notice: i18s(:device) if @device.record.save
    redirect_to edit_device_path(device.id), alert: i18f(:device)
  end

  def destroy
    return redirect_to devices_path, notice: i18s(:device) if device.destroy
    redirect_to devices_path, alert: i18f(:device)
  end

  private

  def permit_params
    record = params[:id] ? device : Device.new
    params.require(:device).permit(:name, :position, :area_id).merge(record: record)
  end

  def device
    @object ||= Device.find(params[:id])
  end

  def areas
    @areas ||= Area.order_alphabet.pluck(:name, :id)
  end
end
