lock '~> 3.18'

set :application, 'my-app'
set :repo_url, 'git@github.com:stawan15/Online-Course-Platform.git'
set :branch, :main

set :deploy_to, '/var/www/my-app'

set :linked_files, %w[config/database.yml config/master.key]
set :linked_dirs,  %w[log tmp/pids tmp/cache tmp/sockets storage public/uploads]

set :keep_releases, 5

# Puma
set :puma_threads,    [4, 16]
set :puma_workers,    2
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_init_active_record, true


set :default_env, {
  path: "/home/eemevuo/.rbenv/shims:/home/eemevuo/.rbenv/bin:$PATH"
}

SSHKit.config.command_map[:bundle] = "/home/eemevuo/.rbenv/shims/bundle"
SSHKit.config.command_map[:ruby] = "/home/eemevuo/.rbenv/shims/ruby"
SSHKit.config.command_map[:gem] = "/home/eemevuo/.rbenv/shims/gem"
SSHKit.config.command_map[:rake] = "/home/eemevuo/.rbenv/shims/rake"