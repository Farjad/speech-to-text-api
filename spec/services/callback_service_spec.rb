require 'spec_helper'
require_relative '../../services/callback_service'

describe CallbackService do
  context 'callback service' do
    it 'sends a call back successfully' do
      allow_any_instance_of(RestClient::Request).to receive(:execute) do
        k = Class.new
        k.define_singleton_method(:code) { 200 }
        k.define_singleton_method(:body) { "{}" }
        k
      end

      expect(CallbackService.new(callback_url: 'http://www.test.com', content: '').call.body).to eq("{}")
    end

    it 'is nil when callback fails' do
      allow_any_instance_of(RestClient::Request).to receive(:execute) { raise }

      expect(CallbackService.new(callback_url: 'http://www.test.com', content: '').call).to eq(nil)
    end
  end
end
