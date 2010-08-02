set :port, 36000

set :user, "twopiradians"
set :deploy_to, "/home/twopiradians/apps/gintellect"

set :rails_env, "production"

role :web, "184.106.229.55"                          # Your HTTP server, Apache/etc
role :app, "184.106.229.55"                          # This may be the same as your `Web` server
role :db,  "184.106.229.55", :primary => true # This is where Rails migrations will run

set :branch, "master"

after "deploy:symlink", "deploy:restart"
namespace :deploy do
  desc "Restart Apache"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:symlink", "git:update_release_branch"
namespace :git do
  desc "Update git rel branch to master"
  task :update_release_branch do
    run "cd #{release_path} && git checkout rel && git merge deploy && git push origin rel"
  end
end 


#after "deploy:update_code" do
#  deploy.bundle
#end

#namespace :deploy do
#  task :bundle do
#    run "cd #{release_path} &&  bundle install"
#  end
#end