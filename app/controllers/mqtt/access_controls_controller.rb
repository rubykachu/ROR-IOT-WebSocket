class Mqtt::AccessControlsController < ApiController
  # @params: prefix/device_name/device_code/....
  # ex: at/light/001/...
  def index
    attrs = {}
    params.keys.each do |key|
      attrs.merge!({ key => params[key] })
    end
    Log.create!(ip_address: request.env['REMOTE_ADDR'], params: attrs)
    # device = DeviceContracts::Base.new(permit_params)
    # raise ActiveRecord::RecordInvalid if device.invalid?
    # device.record.save!
    render json: { status: 200 }, status: 200
  rescue
    render json: { status: 401 }, status: 401
  end

  private

  def write_log

  end

  def permit_params
    segment       = params[:topic].split('/')
    params[:name] = segment[1]
    params[:code] = segment[2]
    params.permit(:name, :code).merge(record: Device.new)
  end
end
