namespace :load do
  task :defaults do
    set :ridgepole_roles, -> { :db }
    set :ridgepole_schema_file, -> { File.join(current_path, "db", "schemas", "Schemafile") }
    set :ridgepole_config_file, -> { File.join(current_path, "config", "database.yml") }
    set :ridgepole_env, -> { fetch(:rails_env) || "development" }
    set :ridgepole_options, -> { "" }
    set :overwrite_migration_tasks, -> { false }
  end
end

namespace :ridgepole do
  desc 'Apply Schemafile with ridgepole'
  task :apply do
    on roles(fetch(:ridgepole_roles)) do
      within current_path do
        if test "! [ -f #{fetch(:ridgepole_schema_file)} ]"
          error "Schema file is not found. Default path to specify Schemafile is #{fetch(:ridgepole_schema_file)}"
          exit 1
        elsif test "! [ -f #{fetch(:ridgepole_config_file)} ]"
          error "Config file is not found. Default path to specify database.yml configuration file is #{fetch(:ridgepole_config_file)}"
          exit 1
        else
          execute :bundle, :exec, "#{ridgepole_base_command}"
        end
      end
    end
  end

  desc 'Test Schemafile application with ridgepole dry-run'
  task :dry_run do
    on roles(fetch(:ridgepole_roles)) do
      within current_path do
        if test "! [ -f #{fetch(:ridgepole_schema_file)} ]"
          error "Schema file is not found. Default path to specify Schemafile is #{fetch(:ridgepole_schema_file)}"
          exit 1
        elsif test "! [ -f #{fetch(:ridgepole_config_file)} ]"
          error "Config file is not found. Default path to specify database.yml configuration file is #{fetch(:ridgepole_config_file)}"
          exit 1
        else
          execute :bundle, :exec, "#{ridgepole_base_command} --dry-run"
        end
      end
    end
  end

  desc 'Show difference that will be created by schema application'
  task :diff do
    on roles(fetch(:ridgepole_roles)) do
      within current_path do
        execute :bundle, :exec, "ridgepole --diff #{fetch(:ridgepole_config_file)} #{fetch(:ridgepole_schema_file)} -E #{fetch(:ridgepole_env)}"
      end
    end
  end

  def ridgepole_base_command
    "ridgepole --apply -E #{fetch(:ridgepole_env)} --file #{fetch(:ridgepole_schema_file)} --config #{fetch(:ridgepole_config_file)} #{fetch(:ridgepole_options)}"
  end
end
