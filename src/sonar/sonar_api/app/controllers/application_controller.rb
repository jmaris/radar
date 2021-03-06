class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def root
    render text: 'Welcome to the Sonar API! You probably wanted to go to host:port/sonar_api_v1/live for live system info'
  end
end
