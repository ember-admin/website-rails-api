APP_ROOT = "/var/www/website-rails-api"

working_directory "#{APP_ROOT}/current"
pid "#{APP_ROOT}/shared/pids/unicorn.pid"
stderr_path "#{APP_ROOT}/shared/log/unicorn.log"
stdout_path "#{APP_ROOT}/shared/log/unicorn.log"

 listen '/tmp/unicorn.admin-rails-api.sock'
#listen 8080, tcp_nopush: true
worker_processes 4
timeout 600

preload_app true

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{APP_ROOT}/current/Gemfile"
end

before_fork do |server, worker|
  # Disconnect since the database connection will not carry over
  if defined? ActiveRecord::Base
    ActiveRecord::Base.connection.disconnect!
  end

  # Quit the old unicorn process
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end

  if defined?(Resque)
    Resque.redis.quit
  end

  sleep 1
end

after_fork do |server, worker|
  # Start up the database connection again in the worker
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end

  if defined?(Resque)
    Resque.redis = 'localhost:6379'
  end
end
