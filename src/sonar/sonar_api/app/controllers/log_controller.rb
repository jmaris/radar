class LogController < ApplicationController

	### VALID URLs:
	## 404
	# sonar_api_v1/logs/custom/%2Fvar%2Flog%2Fmhhhylog.log/%2FALPM%2F
	## Match found
	# sonar_api_v1/logs/custom/%2Fvar%2Flog%2FmYlog.log/%2FALPM%2F
	## Match not found
	# sonar_api_v1/logs/custom/%2Fvar%2Flog%2FmYlog.log/%2FhhhhhhhhhhALPM%2F

	def custom
		path    = params[:path]
		regex 	= eval(params[:regex])

		# byebug

		begin
			open(path)
		rescue
			render json:
			{
				'path':   path, 
				'regex':  regex,
				'match':
				{
					'string': nil,
					'size':   0,
					'status': 'can\'t open file'
				}
			}, status: 404
			return 404
		else
			log 	= open(path)
			file 	= log.read
		end

		if match = regex.match(file)
			render json:
			{
				'path':   path, 
				'regex':  regex,
				'match':
				{
					'string': match.to_s,
					'size':   match.size,
					'status': 'match found'
				}
			}
    	else
			render json:
			{
				'path':   path, 
				'regex':  regex,
				'match':
				{
					'string': nil,
					'size':   0,
					'status': 'match not found'
				}
			}
		end
    end
end