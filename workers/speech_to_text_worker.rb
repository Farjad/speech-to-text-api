require_relative '../services/file_service'
require_relative '../services/callback_service'
require_relative '../services/bluemix_service'

class SpeechToTextWorker
  include SuckerPunch::Job
  workers 4

  def perform(api, audio_url, callback_url)
    begin
      file_service = FileService.new(url: audio_url)
      content = get_content(api, file_service.call)
      file_service.delete
    rescue
      content = '{"status":"invalid file input"}'
    end

    CallbackService.new(callback_url: callback_url, content: content).call
  end

  private

  def get_api(svc)
    services = {
        bluemix: BluemixService
    }
    creds = {
        bluemix: 'bluemix.json'
    }

    raise unless services.has_key?(svc)

    api = JSON.parse(File.read(creds[svc]))
    uri = URI(api['url'])
    api_uri = 'https://' + api['username'] + ':' + api['password'] + '@' + uri.host + uri.path
    services[svc].new(api: api_uri)
  end

  def get_content(api, file)
    api_service = get_api(api)
    api_service.file = file
    api_service.call
  rescue
    '{"status":"an error has occured"}'
  end
end