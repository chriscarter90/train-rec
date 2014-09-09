desc "Runs post deploy setup for the application"
task :post_deploy => :environment do
  Rake::Task["db:migrate"].invoke
  puts "==> Migrations completed...\n"

  Rake::Task["db:seed"].invoke
  puts "==> Database seeding completed...\n"

  puts "==> Post deploy task complete!"
end
