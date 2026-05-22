class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  allow_browser versions: :modern
  stale_when_importmap_changes

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "You are not authorized to do that."
  end
end
