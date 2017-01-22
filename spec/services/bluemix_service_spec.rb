require_relative '../../services/bluemix_service'
require 'pry'

binding.pry
describe BluemixService do
	context 'speech recognition' do
		it 'returns a json' do
			allow_any_instance_of(RestClient::Request).to receive(:execute) { "{}" }
			expect(BluemixService.new(file: nil, api: nil).call)
		end
	end
end
