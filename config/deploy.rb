# config valid for current version and patch releases of Capistrano
lock "~> 3.12.1"

set :application, "self-isolation.run"
set :repo_url, "git@github.com:robjlucas/self-isolation.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, "/home/app"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "storage"

set :rbenv_type, :user
set :rbenv_ruby, File.read(".ruby-version").strip

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :assets_roles, [:app]

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }
after "deploy:symlink:shared", :copy_env_vars
after :deploy, :restart_sidekiq
# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
task :copy_env_vars do
  on roles(:app) do
    execute(:cp, File.join(shared_path, "config/env"), File.join(release_path, ".env"))
  end
end

task :restart_sidekiq do
  on roles(:app) do
    execute("sudo /usr/sbin/service sidekiq restart")
  end
end
