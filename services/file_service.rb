require 'securerandom'
class FileService
  attr_accessor :url, :file_name
  def initialize(url:)
    @url = url
  end

  def call
    @file_name = 'temp/' + SecureRandom.uuid + Pathname(url).extname

    begin
      response = RestClient.get(url)
    rescue
      raise
    end

    File.write(file_name, response.body)
    File.new(file_name)
  end

  def delete
    File.delete(file_name)
  end
end