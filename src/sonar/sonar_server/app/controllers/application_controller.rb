class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def jsontest
    url = 'http://localhost:4963/cpu'
    response = RestClient.get(url)
    @hash = JSON.parse(response)
    render text: "CPU usage is at #{hash["load_percentage"]}%"
  end
end
