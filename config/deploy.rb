# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

set :application, "wacca_ranking"
set :repo_url, "git@github.com:Little-Rubyist/wacca_ranking.git"
set :rbenv_ruby, '3.1.2'
set :deploy_to, "/home/yla_aioi/#{fetch(:application)}"
set :ridgepole_env, fetch(:rails_env)

set :nginx_config_name, "#{fetch(:application)}.conf"
set :nginx_sites_enabled_path, "/etc/nginx/conf.d"

append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "app/assets/images/master"
append :linked_files, "config/database.yml", "db/csvs/console_colors.csv", "db/csvs/custom_titles.csv", "db/csvs/icons.csv", "db/csvs/navigators.csv", "db/csvs/plates.csv", "db/csvs/songs.csv", "db/csvs/titles.csv"

namespace :deploy do
  desc "No ActiveRecord override"
  task :migrate do
  end
  task :migrating do
  end
end

after 'deploy:publishing', 'ridgepole:ridgepole_apply'
namespace :ridgepole do
  desc 'ridgepole apply'
  task :ridgepole_apply do
    invoke 'ridgepole:apply'
  end
end

# TODO: できればExportをしたい．出来るようになったらjavascript/i18-js/translation.jsはGitignoreする
# before 'deploy:assets:precompile', 'i18n:js:export'
# namespace :i18n do
#   namespace :js do
#     desc 'export i18n-js'
#     task :export do
#       invoke 'i18n:js:export'
#     end
#   end
# end

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true