# Puma configuration for both development and production.
# Use environment variables to configure socket, PID, and log paths in production.

threads_count = ENV.fetch("RAILS_MAX_THREADS", 5).to_i
threads threads_count, threads_count

environment ENV.fetch("RAILS_ENV", "development")

if ENV.fetch("RAILS_ENV", "development") == "production"
  app_root = File.expand_path("..", __dir__)
  shared_dir = ENV.fetch("PUMA_SHARED_PATH") { File.join(app_root, "tmp") }

  bind ENV.fetch("PUMA_BIND") { "unix://#{File.join(shared_dir, "sockets", "puma.sock")}" }
  pidfile ENV.fetch("PIDFILE") { File.join(shared_dir, "pids", "puma.pid") }
  state_path ENV.fetch("PUMA_STATE") { File.join(shared_dir, "pids", "puma.state") }
  stdout_redirect ENV.fetch("PUMA_STDOUT") { File.join(app_root, "log", "puma.stdout.log") },
                  ENV.fetch("PUMA_STDERR") { File.join(app_root, "log", "puma.stderr.log") },
                  true
else
  port ENV.fetch("PORT", 3000)
end

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart

# Run the Solid Queue supervisor inside of Puma for single-server deployments.
plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]
