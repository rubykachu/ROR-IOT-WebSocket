class ApplicationController < ActionController::Base
  prepend_view_path Rails.root.join('app', 'javascript')
end
