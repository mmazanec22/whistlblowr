class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  # check_authorization   # This will raise an exception if authorization is not performed in an action.

  skip_authorization_check  # To skip check_authorization

end
