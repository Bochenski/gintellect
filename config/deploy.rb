default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :application, "gintellect"

require 'capistrano/ext/multistage'
set :stages, %w(edge production)
set :default_stage, "production"

require '~/.rvm/lib/rvm/capistrano' # Adjust for load path
set :rvm_ruby_string, 'ruby-1.9.2-p136' # Or whatever env you want it to run in.
set :rvm_type, :user

require 'bundler/capistrano'
set :repository,  "git@github.com:Bochenski/gintellect.git"
set :scm, "git"
set :deploy_via, :remote_cache #this stops capistrano getting the whole repository each time and speeds things up greatly

set :use_sudo, false