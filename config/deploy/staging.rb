# frozen_string_literal: true

set :application, 'practice_staging'
server '192.46.230.54', user: 'deploy', roles: %w[app db web]
set :default_stage, 'staging'
set :stage, :staging
set :branch, ENV['BRANCH'] || 'main'
set :nginx_server_name, 'practice.onbananacoding.com'
set :deploy_to, '/srv/www/apps/practice'
set :puma_service_unit_name, "puma_#{fetch(:application)}"
# Postgres create db
set :pg_ask_for_password, true 