FROM ruby:3.1.2

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle update --bundler \
  && bundle

EXPOSE 3000
