class Mqtt::AuthController < ApiController
  skip_before_action :verify_authenticity_token

  def create
    auth = AuthContracts::Base.new(permit_params)
    render json: { status: 200 }, status: 200 unless auth.invalid?
  rescue
    render json: { status: 401 }, status: 401
  end

  private

  def permit_params
    params.permit(:username, :password).merge(record: User.new)
  end
end
