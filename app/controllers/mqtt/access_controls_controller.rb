class Mqtt::AccessControlsController < ApiController
  # @params: prefix/device_name/device_code/....
  # case 1: at/light/001/        => 200 || 401 && Create device
  # case 2: at/light/+/          => 200 || 401 Get device
  # case 3: at/light/#/          => 200 || 401 Get device
  # case 4: at/+/001/            => 200 || 401 Get device
  # case 5: at/#/001/            => 200 || 401 Get device
  # case 6: at/#/#/              => 200 || 401 Get device
  # case 7: at/#/+/              => 200 || 401 Get device
  # case 8: at/+/+/              => 200 || 401 Get device
  # case 9: at/+/#/              => 200 || 401 Get device
  def index
    format_params
    return status_200 if user.device?(name, code)
    create_device! if Device::CHARACTERS.exclude?(name) && Device::CHARACTERS.exclude?(code)
    status_401
  rescue
    status_401
  end

  private

  attr_reader :name, :code

  def format_params
    segment       = params[:topic].split('/')
    params[:name] = @name = segment[1]
    params[:code] = @code = segment[2]
  end

  def permit_params
    params.permit(:name, :code).merge(record: Device.new)
  end

  def user
    @user ||= User.find_by!(username: params[:username])
  end

  def create_device!
    device = DeviceContracts::Base.new(permit_params)
    raise ActiveRecord::RecordInvalid if device.invalid?
    device.record.save!
  end
end
