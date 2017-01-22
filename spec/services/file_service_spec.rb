require 'spec_helper'
require_relative '../../services/file_service'

describe FileService do
  context 'file service' do
    it 'returns a File object' do
      allow_any_instance_of(RestClient::Request).to receive(:execute) do
        k = Class.new
        k.define_singleton_method(:code) { 200 }
        k.define_singleton_method(:body) { "{}" }
        k
      end

      file_service = FileService.new(url: 'http://www.test.com/test.wav')
      expect(file_service.call).to be_a(File)
      file_service.delete
    end

    it 'raises when there is no valid file' do
      allow_any_instance_of(RestClient::Request).to receive(:execute) { raise }

      expect { FileService.new(url: 'http://www.test.com').call }.to raise_error(RuntimeError)
    end
  end
end
