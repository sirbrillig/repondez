set :application, "repondez"
set :environment, "production"
set :repository,  "git@github.com:sirbrillig/repondez.git"

default_run_options[:pty] = true
set :use_sudo, false
set :rvm_type, :system    # :user is the default
#set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"") # Read from local system
require "rvm/capistrano"
require "bundler/capistrano"
set :rake, "/home/payton/.rvm/gems/ruby-1.9.3-p286@global/bin/rake"

set :scm, :git
set :scm_verbose, true
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/webapps/#{application}"

role :web, "dwalin.foolord.com"
role :app, "dwalin.foolord.com"
role :db, "dwalin.foolord.com", primary: true

after 'deploy:finalize_update', 'deploy:symlink_db', 'deploy:symlink_app'

namespace :deploy do
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Symlinks the application.yml"
  task :symlink_app, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/application.yml #{release_path}/config/application.yml"
  end
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
