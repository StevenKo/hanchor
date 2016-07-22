require 'bundler/capistrano'
require 'capistrano/local_precompile'
# require 'hoptoad_notifier/capistrano'

set :application, "hanchor"
set :rails_env, "production"

set :branch, "master"
set :repository,  "https://github.com/StevenKo/hanchor.git"
set :scm, "git"
set :user, "apps" # 一個伺服器上的帳戶用來放你的應用程式，不需要有sudo權限，但是需要有權限可以讀取Git repository拿到原始碼
set :port, "22"

set :deploy_to, "/home/apps/hanchor"
set :deploy_via, :remote_cache
set :use_sudo, false


role :web, "106.185.28.125"
role :app, "106.185.28.125"
role :db,  "106.185.28.125", :primary => true
# role :web, "139.162.23.149"
# role :app, "139.162.23.149"
# role :db,  "139.162.23.149", :primary => true

set :bundle_cmd, "RAILS_ENV=production bundle"

namespace :deploy do

  task :copy_config_files, :roles => [:app] do
    db_config = "#{shared_path}/config/database.yml"
    run "cp #{db_config} #{release_path}/config/database.yml"
    local_config = "#{shared_path}/config/local_env.yml"
    run "cp #{local_config} #{release_path}/config/local_env.yml"
  end
  
  # task :update_symlink do
  #   run "ln -s {shared_path}/public/system {current_path}/public/system"
  # end
  
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

set :assets_dependencies, %w(app/assets lib/assets vendor/assets Gemfile.lock config/routes.rb)
 
# namespace :deploy do
#   namespace :assets do
 
#     desc <<-DESC
#       Run the asset precompilation rake task. You can specify the full path \
#       to the rake executable by setting the rake variable. You can also \
#       specify additional environment variables to pass to rake via the \
#       asset_env variable. The defaults are:
 
#         set :rake,      "rake"
#         set :rails_env, "production"
#         set :asset_env, "RAILS_GROUPS=assets"
#         set :assets_dependencies, fetch(:assets_dependencies) + %w(config/locales/js)
#     DESC
#     task :precompile, :roles => :web, :except => { :no_release => true } do
#       from = source.next_revision(current_revision)
#       if capture("cd #{latest_release} && #{source.local.log(from)} #{assets_dependencies.join ' '} | wc -l").to_i > 0
#         run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
#       else
#         logger.info "Skipping asset pre-compilation because there were no asset changes"
#       end
#     end
 
#   end
# end

namespace :carrierwave do 
  task :uploads_folder do
    run "mkdir -p #{shared_path}/uploads"
    run "chmod 775 #{shared_path}/uploads"
  end
  after 'deploy:setup', 'carrierwave:uploads_folder'

  task :symlink do 
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end
  after 'deploy', 'carrierwave:symlink'
end

after "deploy", "refresh_sitemaps"
task :refresh_sitemaps do
  run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake sitemap:refresh"
end

before "deploy:assets:precompile", "deploy:copy_config_files" # 如果將database.yml放在shared下，請打開
after "deploy:update_code", "deploy:copy_config_files" # 如果將database.yml放在shared下，請打開
# after "deploy:finalize_update", "deploy:update_symlink" # 如果有實作使用者上傳檔案到public/system，請打開