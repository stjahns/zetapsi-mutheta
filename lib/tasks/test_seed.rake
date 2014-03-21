namespace :db do
  namespace :test do
    task :prepare => :environment do
      Rake::Task["db:populate_content"].invoke
    end
  end
end
