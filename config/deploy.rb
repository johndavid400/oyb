# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, 'oybplugin.com'
set :repo_url, "git@github.com:johndavid400/oyb.git"
set :branch, "master"

set :rvm1_ruby_version, "ruby-2.5.3@oyb"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deployer/oyb"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/master.key')
#set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'vendor/bundle')
#set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp', "public/assets")

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 15

namespace :deploy do

  after :finished, :restart_passenger do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute "~/.rvm/bin/rvm ruby-2.5.3@oyb do sass #{release_path}/app/assets/stylesheets/oyb.scss #{release_path}/public/oyb.css"
        execute 'touch /home/deployer/oyb/current/tmp/restart.txt'
      end
    end
  end

end