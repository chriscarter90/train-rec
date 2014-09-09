namespace :bower do
  desc "Install components from bower"
  task :install do
    sh 'bower install'
  end
end
