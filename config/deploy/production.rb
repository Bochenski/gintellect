set :port, 36000

set :user, "twopiradians"
set :deploy_to, "/home/twopiradians/apps/gintellect"

set :rails_env, "production"

role :web, "www.gintellect.com"                          # Your HTTP server, Apache/etc
role :app, "www.gintellect.com"                          # This may be the same as your `Web` server
role :db,  "www.gintellect.com", :primary => true # This is where Rails migrations will run

set :branch, "edge"

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