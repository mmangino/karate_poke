require 'mongrel_cluster/recipes'
# This defines a deployment "recipe" that you can feed to capistrano
# (http://manuals.rubyonrails.com/read/book/17). It allows you to automate
# (among other things) the deployment of your application.

# =============================================================================
# REQUIRED VARIABLES
# =============================================================================
# You must always specify the application and repository for every recipe. The
# repository must be the URL of the repository you want this recipe to
# correspond to. The deploy_to path must be the path on each machine that will
# form the root of the application path.

set :application, "karate_poke"
set :repository, "svn+ssh://dev.elevatedrails.com/var/svn/repo/karate_poke/trunk"

# =============================================================================
# ROLES
# =============================================================================
# You can define any number of roles, each of which contains any number of
# machines. Roles might include such things as :web, or :app, or :db, defining
# what the purpose of each machine is. You can also specify options that can
# be used to single out a specific subset of boxes in a particular role, like
# :primary => true.


set :deploy_to, '/u/apps/karate_poke'
set :user, 'mmangino'
set :use_sudo, false
set :mongrel_conf, "#{current_path}/config/karate_poke.yml"  
role :web, "basie.elevatedrails.com"
role :app, "basie.elevatedrails.com"
role :db,  "basie.elevatedrails.com", :primary => true




desc "Deploy, migrate and update"
namespace :deploy do
  task :full do
    transaction do
      update_code
      web.disable
      symlink
      migrate
      copy_facebooker_yml
    end

    restart
    web.enable
    cleanup
  end
end

task :copy_facebooker_yml, :roles =>:web do
  run "cp #{shared_path}/facebooker.yml #{release_path}/config/"
end

