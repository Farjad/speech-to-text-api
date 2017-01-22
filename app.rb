# encoding: utf-8
require 'sinatra'
require 'rack/contrib'
require 'sucker_punch'
require 'rest-client'
require_relative 'workers/speech_to_text_worker'


class App < Sinatra::Application
	helpers do
		include Rack::Utils
	end

	use Rack::PostBodyContentTypeParser

	post '/process' do
		audio_url = params['audio_url']
		callback_url = params['callback_url']
		api = params['api'] || 'bluemix'
		SpeechToTextWorker.perform_async(api.to_sym, audio_url, callback_url)
  end
end