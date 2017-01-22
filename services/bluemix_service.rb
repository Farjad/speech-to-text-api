class BluemixService
	attr_accessor :file, :model, :content_type, :api
	attr_writer :file
	def initialize(model: 'en-US_NarrowbandModel', content_type: 'audio/wav', api:)
		@model = model
		@content_type = content_type
		@api = api
	end

	def call
		speech_to_text
	end

	private

	def speech_to_text
		response = RestClient.post(api + '/v1/recognize?model=' + model, file, :content_type => content_type)
		if response.code == 200
			JSON.parse(response.body)
		else
			raise
		end
	end
end
