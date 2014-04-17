#!/bin/bash
#davidsone
#24/2/2014

# Tell bash that we want the whole script to fail if any part fails.
#set -e

# http://rvm.io/rvm/basics rvm must be loaded as a function
#source "$rvm_path/scripts/rvm"

#Global Variables
SOURCE_DIR=`pwd`
#Build args
ALPHA=$1
BETA=$2

#Begin
echo "*************************************"
echo "Running build script..."
echo "PWD :"$SOURCE_DIR
echo "Build args: $1 $2"

main() {

	echo "*************************************"
	startTime=$(date +%s)

	#ensure using rvm1.9.3
	#rvm use ruby-1.9.3 --fuzzy

	RUBY_VERSION=`cat RUBY_VERSION`
	echo RUBY_VERSION is \'$RUBY_VERSION\'

	rvm $RUBY_VERSION exec bundle install --path vendor/bundle
	rvm $RUBY_VERSION exec bundle rake spec_unit_ci
	rvm $RUBY_VERSION exec bundle metrics:all
	rvm $RUBY_VERSION exec bundle code_metrics:stats

	#bundle install
	#bundle exec 
	#bundle exec rake 
	#bundle exec rake code_metrics:stats

	endTime=$(date +%s)
	timeDifference=$(( $endTime - $startTime ))

	echo "Execution time :" $timeDifference
	echo "Finished."

}

#RUN
main