class AreasController < ApplicationController
  before_action :authenticate

  def index
  end

  def new
    @area = AreaContracts::Base.new(record: Area.new)
  end

  def create
    @area = AreaContracts::Base.new(permit_params)
    return render :new if @area.invalid?
    return redirect_to save_another_path(areas_path, new_area_path), notice: i18s(:area) if @area.record.save
    redirect_to new_area_path, alert: i18f(:area)
  end

  private

  def permit_params
    record = params[:id] ? area : Area.new
    params[:area][:slug] = params[:area][:name].parameterize
    params.require(:area).permit(:name, :slug).merge(record: record)
  end

  def area
    @object ||= Area.find(params[:id])
  end
end
