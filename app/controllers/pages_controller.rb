require 'rest-client'
require 'json'

class PagesController < ApplicationController
	def index

	end

	def about
		@title = 'About us'
		@content = 'Projeto de Técnicas de Programação II'
	end

	def result
	  	#aqui pega da API
	  	input = params[:param]
	  	if input.to_s.empty?
	  		render html: "Please provide a valid Codeforces handle!"
	  		return
	  	end
	  	base = 'http://codeforces.com/api/user.info?handles='
	  	url = base + input.to_s
	  	response = RestClient.get(url)

	  	#pra printar o json todo com os keys e values
	  	#render json: response

	  	#parse o objeto JSON
	  	parsed = JSON.parse(response)

	  	#pega os values da key "result" e coloca em info
	  	info = parsed['result'][0]

	  	#pra printar a organizacao, por exemplo:
	  	#render html: info['organization']

	  	#pra printar o status (se deu ok ou nao)
	  	#render html: parsed['status']

	  	#pra printar o lastname:
	  	#render html: info['lastName']

	  	@firstName = info['firstName']
	  	@lastName = info['lastName']
	  	@organization = info['organization']
	  	@rating = info['rating'].to_s
	  	@handle = info['handle']

  end


end
