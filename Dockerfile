FROM ruby:2.3.3

COPY . /speechToTextApi

WORKDIR /speechToTextApi

RUN gem install bundler && bundle

ENTRYPOINT ["thin","-R","config.ru","start"]
