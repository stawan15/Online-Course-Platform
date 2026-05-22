lock '~> 3.20.0'

set :application, 'practice'
set :repo_url, 'git@github.com:stawan15/Online-Course-Platform.git'
set :branch, :main

set :default_stage, 'staging'
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/srv/www/apps/practice'

# puma setup
set :puma_threads,    [4, 16]
set :puma_workers,    1
# Don't change these unless you know what you're doing
set :use_sudo,        false
set :stage,           :staging
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app, false
set :puma_daemonize, false
set :puma_worker_timeout, nil
set :puma_init_active_record, true # Change to true if using ActiveRecord
set :puma_service_unit_name, "puma_#{fetch(:application)}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/storage.yml', 'puma.rb', 'config/credentials/staging.yml.enc',
       'config/application.yml'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', '.bundle', 'public/system', 'public/uploads',
       'storage'

# Default value for default_env is {}
set :default_env, { path: "/home/deploy/.rbenv/shims:/home/deploy/.rbenv/bin:$PATH", 'RAILS_MASTER_KEY' => "731d31401fe9648f7741dd36dc073947" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# Default value for keep_releases is 5
set :keep_releases, 5
set :rbenv_type, :user
set :rbenv_path, '/home/deploy/.rbenv'
set :rbenv_ruby, '3.2.2'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
# set :rvm_type, :user              # Defaults to: :auto
# set :rvm_ruby_version, '3.0.0'      # Defaults to: 'default'

# Remove if not using Webpacker
set :assets_prefix, 'packs'

set :nginx_config_name, fetch(:application).to_s
set :nginx_flags, 'fail_timeout=0'
set :nginx_http_flags, fetch(:nginx_flags)
set :nginx_conf_path, '/etc/nginx/conf.d'

set :conditionally_migrate, true # Only attempt migration if db/migrate changed

namespace :deploy do
  desc 'Restart application'
  Rake::Task['puma:restart'].clear_actions
  task :restart do
    on roles(:app) do
      execute "sudo systemctl restart #{fetch(:puma_service_unit_name)}"
      execute "sudo systemctl restart sidekiq_#{fetch(:application)}"
    rescue StandardError
      execute "sudo systemctl start #{fetch(:puma_service_unit_name)}"
      execute "sudo systemctl restart sidekiq_#{fetch(:application)}"
    end
  end
  after :finishing, :restart
end
