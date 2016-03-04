# config valid only for current version of Capistrano
# require 'capistrano/bundler'

lock '3.4.0'

set :application, 'bitbillers'
set :repo_url, 'git@github.com:pebiantara/bitbillers.git'

set :rails_env, "production"
set :env, "production"

set :domain, "104.236.38.53"
set :user, "bitbillers"
set :port, 22
set :branch, "master"
set :deploy_to, "/home/bitbillers/backend"

set :keep_releases, 5
set :use_sudo, true

set :deploy_via, :remote_cache
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set(:config_files, %w(
  nginx.conf
  unicorn.rb
  unicorn_init.sh
))

set(:executable_config_files, %w(
  unicorn_init.sh
))


set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/etc/nginx/sites-enabled/{{application}}"
  },
  {
    source: "unicorn_init.sh",
    link: "/etc/init.d/unicorn_{{application}}"
  }
])

# namespace :deploy do
#   # after "deploy", "deploy:cleanup"
#   # after "deploy", "deploy:migrate"

#   task :migrate do
#     run "cd #{current_path} && rake db:migrate RAILS_ENV=production "
#   end

#   task :bundling do
#     sudo "cd #{current_path} && bundle install"
#   end

#   task :restart_unicorn, roles: :app, except: {no_release: true} do
#     sudo "sudo /etc/init.d/unicorn_#{application} restart"
#   end
  
#   namespace :deface do
#     task :precompile do
#     end
#     after 'deploy:finished', 'deploy:bundling'
#     after 'deploy:finished', 'deploy:migrate'
#     # after 'deploy:finished', 'deploy:deface:precompile'
#     after 'deploy:finished', 'deploy:restart_unicorn'
#   end 
# end

namespace :deploy do
  task :setup_config do
    on roles(:app) do
      execute :sudo, "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/landing_page"
      execute :sudo, "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_landing"
    end
  end

  task :migrate do
    execute :cd, "#{current_path} && rake db:migrate RAILS_ENV=production "
    execute :cd, "#{current_path} && rake db:seed RAILS_ENV=production "
  end

  task :precompile do
    execute :cd, "#{current_path} && rake assets:precompile RAILS_ENV=production"
  end

  task :bundling do
    execute :sudo, "cd #{current_path} && bundle install"
  end

  task :restart_unicorn do
    execute :sudo, "/etc/init.d/unicorn_landing stop"
    execute :sudo, "/etc/init.d/unicorn_landing start"
  end
end

# FIXED ME LATER

# after 'deploy:finished', 'deploy:bundling'
# after 'deploy:finishing', 'deploy:setup_config'
# after 'deploy:finished', 'deploy:migrate'
# after 'deploy:finished', 'deploy:precompile'
# after 'deploy:finished', 'deploy:restart_unicorn'

# namespace :deploy do

#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end

# end
