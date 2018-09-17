# /path/to/app/Dockerfile
FROM ruby:2.3.7

RUN apt-get update -qq && apt-get install -y nodejs libffi-dev sqlite


ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock
RUN bundle install --jobs=2

COPY . $APP_HOME


# Настройка переменных окружения для production
ENV RAILS_ENV=production \
    RACK_ENV=production