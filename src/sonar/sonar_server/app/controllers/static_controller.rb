class StaticController < ApplicationController
	def show
		render template: "static/#{params[:static]}"
	end
end
