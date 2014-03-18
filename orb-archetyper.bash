#!/bin/bash
#davidsone
#24/2/2014

# Tell bash that we want the whole script to fail if any part fails.
set -e

# http://rvm.io/rvm/basics rvm must be loaded as a function
source "$rvm_path/scripts/rvm"

#Global Variables
SOURCE_DIR=`pwd`
#Build args
ALPHA=$1
BETA=$2

#Begin
echo
echo "Run build script..."
echo "Build args: $1 $2"
echo "PWD :"$SOURCE_DIR

main() {

	echo "Executing..."
	startTime=$(date +%s)

	#ensure using rvm1.9.3
	rvm use ruby-1.9.3
	bundle install

	bundle exec rake spec_unit
	bundle exec rake metrics:all

	endTime=$(date +%s)
	timeDifference=$(( $endTime - $startTime ))

	echo "Execution time :" $timeDifference
	echo "Finished."

}

#RUN
main