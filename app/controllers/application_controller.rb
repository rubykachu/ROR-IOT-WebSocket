class ApplicationController < ActionController::Base
  prepend_view_path Rails.root.join('app', 'javascript')
  include ApplicationHelper

  def authenticate
    return redirect_to sign_in_path unless logined?
    current_user
  end
end
