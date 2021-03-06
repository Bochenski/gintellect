set :user, "twopiradians"
set :password, "Glieck>21"
set :deploy_to, "/home/twopiradians/apps/gintellect"

set :rails_env, "edge"

role :web, "twopiradians"                          # Your HTTP server, Apache/etc
role :app, "twopiradians"                          # This may be the same as your `Web` server
role :db,  "twopiradians", :primary => true # This is where Rails migrations will run

set :branch, "master"

after "deploy:symlink", "deploy:restart"
namespace :deploy do
  desc "Restart Apache"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:symlink", "git:update_edge_branch"
namespace :git do
  desc "Update git edge branch to master"
  task :update_edge_branch do
    run "cd #{release_path} && git checkout edge && git merge deploy && git push origin edge"
  end
end 


#after "deploy:update_code" do
#  deploy.bundle
#end

#namespace :deploy do
#  task :bundle do
#    run "cd #{release_path} && #{sudo} RAILS_ENV=#{rails_env} bundle install #{shared_path}/gems/cache"
#  end
#end