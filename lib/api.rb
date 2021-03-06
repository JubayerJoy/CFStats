module Api

	# Generic function to call the API
	def call_api (url)
		begin
			response_from_api = RestClient.get(url)
			parsed_json = JSON.parse(response_from_api)
			return parsed_json
		rescue => exception
			puts("Bad request  =>  ", exception.http_code)
		end
	end

	# BasicGeneric function to call the API to retrieve user info
	def get_user_info (handle)
		base = 'http://codeforces.com/api/user.info?handles='
		url = base + handle.to_s
		return call_api(url)
	end

	# Basic function to call the API to retrieve user problems
	def get_user_problems (handle)
		base = 'http://codeforces.com/api/user.status?handle='
		url = base + handle.to_s
		api = call_api(url)
		return api['result']
	end

	# Basic function to call the API to retrieve contests solved by an user
	def get_user_contests (handle)
		base = 'http://codeforces.com/api/user.rating?handle='
		url = base + handle.to_s
		api = call_api(url)
		return api['result']
	end

	# Validates all input to check if they are a valid handle, contest or problem on Codeforces
	# Returns true if valid, false otherwise
	def validate (id, type)
		if (type == "handle")
			begin
				base = "http://codeforces.com/api/user.info?handles="
				url = base + id.to_s
				response_from_api = RestClient.get(url)
				return get_user_info(id)['result'][0]['handle']
			rescue => exception
				return false
			end

		elsif (type == "contest")
			begin
				base = "http://codeforces.com/api/contest.status?contestId="
				url = base + id.to_s + "&count=1"
				response_from_api = RestClient.get(url)
				return true
			rescue => exception
				return false
			end

		elsif (type == "problem")
			base = "http://codeforces.com/api/problemset.problems"
			url = base
			all_problems = call_api(url)["result"]["problems"]
			
			id_size = id.length
			problem_index = id[id_size-1]
			problem_index.upcase!
			contest_number = id[0...-1]
			for problem in all_problems
				if problem["contestId"].to_s == contest_number
					if problem["index"].to_s == problem_index
						return true
					end
				end 
			end
			return false
		end
	end
end