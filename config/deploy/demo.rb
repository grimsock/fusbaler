server 'fusbaler.demo.llp.pl', :app, :web, :db, primary: true
set :port, 20018
set :user, "fusbaler"
set :use_sudo, false
set :deploy_to, "/home/app/fusbaler"
set :keep_releases, 3
set :branch, :master
