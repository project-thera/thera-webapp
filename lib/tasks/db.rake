namespace :db do
  desc "Drops, creates, migrates and seeds the database"
  task rebuild: :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end

  namespace :data do
    desc "Invokes all data load tasks"
    task load: :environment do
      # Rake::Task['rules:load_csv'].invoke
    end
  end
end