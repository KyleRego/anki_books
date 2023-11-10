FROM ruby:3.2.1

LABEL maintainer="regoky@outlook.com"

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends libvips libvips-tools

COPY . /usr/src/app

WORKDIR /usr/src/app

RUN bundle install

CMD ["passenger", "start"]
