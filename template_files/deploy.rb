# config valid only for current version of Capistrano
lock "3.7.1"

set :application, 'ghtest'
set :repo_url, 'git@github.com:scieslak/ghtest.git'

set :user, "admin-sc"
set :server_ip, "52.213.177.208"
set :pty, true
set :console_env, :production
set :console_user, fetch(:user)

set :puma_threads, [0, 5]
set :puma_workers, 2
set :puma_jungle_conf, '/etc/puma.conf'
set :puma_run_path, '/usr/local/bin/run-puma'

set :rvm_ruby_version, '2.3.3@rails5.0.0.1'

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
set :linked_files, fetch(:linked_files, []).push('config/secrets.yml', 'config/database.yml')

before "deploy:check:linked:files", "prepare:copy"
after "deploy", "puma:nginx_config"
after "puma:nginx_config", "puma:config"

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
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5
