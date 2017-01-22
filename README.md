# Speech to Text Api
------------

### Usage

```ssh
curl -X POST -d '{"audio_url":"http://path/to/wav","callback_url":"http://path/to/callback"}' http://path.to.service:3000/process
```

### Currently Supported

#### Blumix Api - bluemix.json
Format
```json
{
  "url": "https://stream.watsonplatform.net/speech-to-text/api",
  "password": "",
  "username": ""
}
```

Start service
```
thin -R config.ru start