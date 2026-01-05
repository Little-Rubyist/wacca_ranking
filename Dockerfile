FROM ruby:3.2.0

ENV APP_ROOT /app
ENV LANG ja_JP.UTF-8

RUN apt-get update && apt-get -y install bash vim locales-all

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN mkdir -p "$APP_ROOT"
WORKDIR "$APP_ROOT"


COPY Gemfile "$APP_ROOT"
COPY Gemfile.lock "$APP_ROOT"
RUN bundle install

COPY . "$APP_ROOT"

# Entrypoint
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
