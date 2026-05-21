server '127.0.0.1', user: 'eemevuo', roles: %w{app db web}, port: 2222

set :ssh_options, {
  keys: %w[~/.ssh/id_ed25519],
  forward_agent: true,
  auth_methods: %w[publickey]
}