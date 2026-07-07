namespace :ridgepole do
  desc 'Apply database schema'
  task apply: :environment do
    ridgepole('--apply', "--file #{schema_file}")
  end

  desc 'Export database schema'
  task export: :environment do
    ridgepole('--export', '--split', "--output #{schema_file}")
  end

  private

  def schema_file
    Rails.root.join('db/schemas/Schemafile') # rubocop:disable Rails/FilePath
  end

  def config_file
    Rails.root.join('config/database.yml') # rubocop:disable Rails/FilePath
  end

  def ridgepole(*options)
    command = [
      'bundle exec ridgepole',
      "--config #{config_file}",
      "-E #{Rails.env}",
      "--require #{Rails.root.join('config/environment')}",
    ]
    system [command + options].join(' ')
  end
end