class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def root
    render text: 'Please specify the API version like "host:port/sonar_api_v1"'
  end
end
