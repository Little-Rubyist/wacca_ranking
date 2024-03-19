# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

  3.1.2

* System dependencies

* Configuration

* Database creation

1. `cp template/database.yml config/database.yml`
2. `rails db:create`

* Database initialization

  `bundle exec ridgepole -c config/database.yml -E development -f db/schemas/Schemafile --apply`

  or

  `rails ridgepole:apply`

* credentials

  memo: add credentials key
  
  `bundle exec rails credentials:edit RAILS_ENV=env`

* deployment

  `bundle exec cap production deploy`

* How to run the test suite

  sorry, I don't write tests :(

* Services (job queues, cache servers, search engines, etc.)

* Development

1. Clone it
2. remove `secrets: - host_ssh_key` in docker-compose.yml (this key is for deployment)
3. `docker compose build` and `docker compose up -d`

* Translation

  I'm translating it little by little, but it is not finished. sorry :(

  Delete the Japanese part of the `app/views` and add the translated text in `config/locales` according to Rails i18n

  Reloading will regenerate `translation.js` so the same locales can be used in JS files (perhaps you should reboot instance)

  I have prepared an i18n configuration for `views/user_songs/index.html.haml` as a reference (please add other languages setting)

* Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Added some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

