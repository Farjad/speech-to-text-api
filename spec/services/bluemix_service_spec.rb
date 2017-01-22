require 'spec_helper'
require_relative '../../services/bluemix_service'

describe BluemixService do
	context 'speech recognition' do
		it 'returns a json' do
			allow_any_instance_of(RestClient::Request).to receive(:execute) do
				k = Class.new
				k.define_singleton_method(:code) { 200 }
				k.define_singleton_method(:body) { "{}" }
				k
			end

			expect(BluemixService.new(api: 'http://www.test.com').call).to eq({})
    end

		it 'raises error on response of non-success' do
			allow_any_instance_of(RestClient::Request).to receive(:execute) do
				k = Class.new
				k.define_singleton_method(:code) { 404 }
				k
			end

			expect { BluemixService.new(api: 'http://www.test.com').call }.to raise_error(RuntimeError)
		end
	end
end
