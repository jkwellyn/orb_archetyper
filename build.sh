#!/bin/bash -l
# We use a login shell in order to have RVM already loaded to the path and available for use

# Tell bash that we want the whole script to fail if any part fails.
set -e

SOURCE_DIR=`pwd`

# Begin
echo "*************************************"
echo "Running build script..."
echo "PWD :"$SOURCE_DIR
echo "Build args: $1 $2"

main() {

  echo "*************************************"
  startTime=$(date +%s)

  echo WHICH rvm is `which rvm`
  echo RVM LIST is `rvm list`

  # First, use any available ruby to get opower-deployment gem
  # We use 1.9.3 because orb_archetyper has some specific gems with ruby requirement >= 1.9.3 (e.g. activesupport)
  rvm use 1.9.3 --fuzzy
  bundle install
  # access the official ruby version in that gem
  RUBY_VERSION_FILE="`bundle show opower-deployment`/lib/opower/APP_RUBY_VERSION"
  RUBY_VERSION=`cat $RUBY_VERSION_FILE`
  echo RUBY_VERSION is \'$RUBY_VERSION\'

  # use the official Opower approved ruby version to run our tests against
  rvm use $RUBY_VERSION

  bundle install
  bundle exec rake build

  endTime=$(date +%s)
  timeDifference=$(( $endTime - $startTime ))

  echo "Execution time :" $timeDifference
  echo "Finished."

}
# RUN
main
