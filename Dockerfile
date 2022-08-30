FROM ruby:3.1

ENV APP_ROOT /app
# シェルスクリプトとしてbashを利用
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

RUN apt-get update && apt-get -y install vim
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs
RUN npm install --global yarn
COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT
RUN bundle install
COPY . $APP_ROOT

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
