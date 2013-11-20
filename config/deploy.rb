require 'capistrano/ext/multistage'
require 'rvm/capistrano'

set :application, "fusbaler"
set :repository,  "git@github.com:grimsock/fusbaler.git"
set :rails_env, "production"
set :deploy_env, "production"

set :deploy_via, :remote_cache
set :scm, :git
set :stages, ["demo", "production"]
set :default_stage, "demo"
set :rvm_type, :system
set :rvm_ruby_string, "2.0.0"

ssh_options[:forward_agent] = true

before "deploy:assets:precompile" do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  run "ln -nfs #{shared_path}/config/unicorn.rb #{release_path}/config/unicorn.rb"
end

after "deploy:update_code", "deploy:migrate"
after "deploy:update_code" do
  run "cd #{release_path} && bundle exec rake db:seed RAILS_ENV=#{deploy_env}"
end

after "deploy:restart", "deploy:cleanup"
