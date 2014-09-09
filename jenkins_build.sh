export PATH=/usr/local/pearson/ruby193/bin:$PATH

set -o verbose

# Clean up left over stuff from previous builds (logs etc...)
time git clean -fdx -e "/vendor/bundle"

time bundle install --no-color --without development --frozen --deployment --clean

# Setup database
cp -f config/database_jenkins.yml config/database.yml
cp -f config/carrierwave.yml.example config/carrierwave.yml
RAILS_ENV=test time bundle exec rake db:drop db:setup
bower install

# Show some info about the current environment to debug potential issues
bundle env
id

# Clean up old assets and precompile ready for production
# We do this before testing so that we can make sure the
# test suite fails if asset compilation does not run correctly
RAILS_ENV=production time bundle exec rake tmp:clear
RAILS_ENV=production time bundle exec rake assets:clean
RAILS_ENV=production time bundle exec rake assets:precompile

# Run Tests
RAILS_ENV=test CI=true time bundle exec rake
RAILS_ENV=test CI=true time bundle exec rake spec:javascript
# Write latest revision in version.txt
version=$1
# First the closest tag...
if [[ -z "$version" ]]; then
  version=`git describe --abbrev=0 HEAD --tags`
fi
echo $version > public/version.txt
# ...then the SHA1
git rev-parse HEAD >> public/version.txt

# TODO: remove .git dirs to reduce payload
