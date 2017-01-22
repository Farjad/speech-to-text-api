class CallbackService
  attr_accessor :callback_url, :content
  def initialize(callback_url:, content:)
    @callback_url = callback_url
    @content = content
  end

  def call
    RestClient.post(callback_url, content, {:content_type => 'application/json'})
  rescue
    # do nothing
  end
end