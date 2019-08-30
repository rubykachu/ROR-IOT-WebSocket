class LogsController < ApplicationController
  def index
    @logs = Log.common_order.page(params[:page]).per(5)
  end
end
