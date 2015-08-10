#!/bin/bash --login
# We use a login shell in order to have RVM already loaded to the path and available for use.

# Tell bash that we want the whole script to fail if any part fails.
set -e

# Global Variables
SOURCE_DIR=`pwd`

function set_ruby_manager() {
  echo "checking ruby manager"
  if hash rvm 2>/dev/null;
  then
    echo 'using rvm to manage ruby'
    set_cmd='rvm use $RUBY_VERSION'
    execute_cmd=''
  else
    echo 'using rbenv to manage ruby'
    set_cmd='rbenv shell $RUBY_VERSION'
    execute_cmd='rbenv exec'
  fi
}

# Begin
echo "*************************************"
echo "Running build script..."
echo "PWD :"$SOURCE_DIR
echo "Build args: $1 $2"

main() {
  echo "*************************************"
  startTime=$(date +%s)

  if [ -z "$RUBY_VERSION" ]
  then
    echo "You must set the environment variable RUBY_VERSION to the ruby version you wish to use: "
    echo "export RUBY_VERSION=1.9.3-p392"
    exit 1
  fi

  echo "Using Ruby ${RUBY_VERSION}"

  set_ruby_manager
  eval $set_cmd

  eval "${execute_cmd} bundle install"

  if [ $RELEASE ]
  then
    echo "Releasing."
    eval "${execute_cmd} bundle exec rake release"
  else
    echo "Not releasing, just doing a build."
    eval "${execute_cmd} bundle exec rake build"
  fi

  endTime=$(date +%s)
  timeDifference=$(( $endTime - $startTime ))

  echo "Execution time :" $timeDifference
  echo "Finished."

}

#RUN
main
