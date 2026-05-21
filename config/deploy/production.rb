# config/deploy/production.rb
server '127.0.0.1', user: 'deploy', roles: %w[app db web]

set :ssh_options, {
  keys: %w[~/.ssh/id_rsa],
  forward_agent: true,
  auth_methods: %w[publickey]
}