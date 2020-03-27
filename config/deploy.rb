# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"
set :application, 'hotelolite'
set :rvm_ruby_version, '2.5.3'
set :repo_url, 'git@github.com:akashkinwad/hotelolite.git'
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/assets"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      execute :touch, release_path.join('tmp/restart.txt')
     #  run("cd #{deploy_to}/current &&  rvmsudo passenger start -e production -p80 -d --user=deploy")
      execute "chmod 777 #{release_path}/Gemfile.lock"
      execute "chmod -R 777 #{release_path}/tmp/cache"
      execute "chmod -R 777 #{release_path}/app/assets"
      execute "chmod 777 #{release_path}/log"
    end
  end

  after :publishing, :restart

end

