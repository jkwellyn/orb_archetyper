#!/bin/bash
#davidsone
#24/2/2014

# http://rvm.io/rvm/basics rvm must be loaded as a function
source "$rvm_path/scripts/rvm"

# Tell bash that we want the whole script to fail if any part fails.
set -e

#Global Variables
#cd ..
SOURCE_DIR=`pwd`

#Begin
echo
echo ":::Orb Archetyper::: Do Build"
echo "PWD :"$SOURCE_DIR

main() {

	echo "Executing..."
	startTime=$(date +%s)

	#this does not work on ci-sandbox due to login shell issue. Will be added for master.
	#ensure using rvm1.9.3
	rvm use ruby-1.9.3
	bundle install

	bundle exec rake rspec_unit

	endTime=$(date +%s)
	timeDifference=$(( $endTime - $startTime ))

	echo "Execution time :" $timeDifference
	echo "Fin."

}

#RUN
main