#!/bin/bash
#davidsone
#24/2/2014

# Tell bash that we want the whole script to fail if any part fails.
set -e

source "$rvm_path/scripts/rvm"

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

    #Grab rvm version from the gemspec
    #TODO is there a better way to do this??
	rvmVersion=`grep -o 'required_ruby_version.*' orb-archetyper.gemspec`
    reg_pattern='\".* ([0-9.]+)\"'
    [[ $rvmVersion =~ $reg_pattern ]]
    rvmVersionStr=''
    i=1
    n=${#BASH_REMATCH[*]}
    while [[ $i -lt $n ]]
    do
        rvmVersionStr+=${BASH_REMATCH[$i]}
        let i++
    done
	rvm use $rvmVersionStr --fuzzy

	bundle install
	bundle exec rake spec_unit_ci
	bundle exec rake metrics:all
	bundle exec rake code_metrics:stats

	endTime=$(date +%s)
	timeDifference=$(( $endTime - $startTime ))

	echo "Execution time :" $timeDifference
	echo "Finished."

}

#RUN
main
