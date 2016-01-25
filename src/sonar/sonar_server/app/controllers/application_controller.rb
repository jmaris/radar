class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def test
      render text: "this is a test"
  end
  def jsontest
      require 'json'
      # require 'awesome_print'
      # require 'httparty'
      t = ap JSON.parse HTTParty.get('http://127.0.0.1:4963/cpu').response.body
      # jsonroute = "http://127.0.0.1:4963/cpu"
      # t = JSON.parse jsonroute
      render text: "CPU = #{t}"
  end
end
