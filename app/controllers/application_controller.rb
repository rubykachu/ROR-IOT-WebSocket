class ApplicationController < ActionController::Base
  prepend_view_path Rails.root.join('app', 'javascript')
  before_action :set_data_controller

  include ApplicationHelper

  # Authenticate
  def authenticate
    return redirect_to sign_in_path unless logined?
  end

  private

  def set_data_controller
    @controller_data =
      {
        controller_name: self.controller_name,
        action_name: self.action_name,
        path: self.controller_path
      }
  end
end
