require_relative '../services/file_service'
require_relative '../services/callback_service'
require_relative '../services/bluemix_service'

class SpeechToTextWorker
  include SuckerPunch::Job

  def perform(api, audio_url, callback_url)
    file_service = FileService.new(url: audio_url)
    content = get_content(api, file_service.call)
    CallbackService.new(callback_url: callback_url, content: content).call
    file_service.delete
  end

  private

  def get_api(api)
    case api
      when :bluemix
        file = 'bluemix.json'
        klass = BluemixService
      when :google
        # do nothing
      when :azure
        # do nothing
      else
        # do nothing
    end

    api = JSON.parse(File.read(file))
    uri = URI(api['url'])
    api_uri = 'https://' + api['username'] + ':' + api['password'] + '@' + uri.host + uri.path
    klass.new(api: api_uri)
  end

  def get_content(api, file)
    api_service = get_api(api)
    api_service.file = file
    api_service.call
  end
end