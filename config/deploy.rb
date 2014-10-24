# config valid only for Capistrano 3.1
lock '3.1.0'

set :repo_url, 'git@github.com:ember-admin/website-rails-api.git'

set :application, "website-rails-api"
set :deploy_to,   "/var/www/website-rails-api"
set :rails_env, fetch(:stage)

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :rvm1_ruby_version, "ruby-2.1.1"

set :migration_role, 'app'            # Defaults to 'db'
# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w(log pids sockets tmp public/uploads bin)

# set :rvm_ruby_string, :local              # use the same ruby as used locally for deployment

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

#set :sidekiq_pid,  File.join(shared_path, 'pids', 'sidekiq.pid')

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  task :make_assets_symlink do
    on roles(:app) do
      if fetch(:stage) == :production
        execute "ln -sf /var/www/website-ember-cli-part/current/dist #{release_path}/public/dist"
      end
    end
  end
end

after  'deploy:publishing',          'deploy:make_assets_symlink'
after  'deploy:make_assets_symlink', 'deploy:restart'

namespace :unicorn do
  pid_path = "#{release_path}/pids"
  unicorn_pid = "#{pid_path}/unicorn.pid"

  def run_unicorn
    execute "#{fetch(:bundle_binstubs)}/unicorn", "-c #{release_path}/config/unicorn/#{fetch(:stage)}.rb -D -E #{fetch(:stage)}"
  end

  desc 'Start unicorn'
  task :start do
    on roles(:app) do
      run_unicorn
    end
  end

  desc 'Stop unicorn'
  task :stop do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-QUIT `cat #{unicorn_pid}`"
      end
    end
  end

  desc 'Force stop unicorn (kill -9)'
  task :force_stop do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-9 `cat #{unicorn_pid}`"
        execute :rm, unicorn_pid
      end
    end
  end

  desc 'Restart unicorn'
  task :restart do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-USR2 `cat #{unicorn_pid}`"
      else
        run_unicorn
      end
    end
  end
end
