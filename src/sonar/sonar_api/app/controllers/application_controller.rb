class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def root
    render text: "this is the root of the sonar API server...\n 
    you're probably looking for http://127.0.0.1:4963/cpu"
end
end
