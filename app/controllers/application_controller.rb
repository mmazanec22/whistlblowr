class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_investigator!, :except => [:registrations]
  # before_filter :authenticate_investigator!
  #   before_filter do
  #     redirect_to :new_investigator_session_path unless current_investigator && current_investigator.admin?
  # end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    complaints_path
  end

  # check_authorization :unless => :devise_controller?  # This will raise an exception if authorization is not performed in an action.

  skip_authorization_check  # To skip check_authorization

end
