#!/bin/bash --login

SOURCE_DIR=`pwd`

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

	echo WHICH rvm is `which rvm`
	echo RVM LIST is `rvm list`

	# using the opower-deployment standard ruby version to run our tests against
    rvm use 1.9.3 --fuzzy
    bundle install --path vendor/bundle
    RUBY_VERSION_FILE="`bundle show opower-deployment`/lib/opower/APP_RUBY_VERSION"
    RUBY_VERSION=`cat $RUBY_VERSION_FILE`
	echo RUBY_VERSION is \'$RUBY_VERSION\'

	rvm use $RUBY_VERSION

    bundle install  --path vendor/bundle
	bundle exec rake spec:full --trace
	bundle exec rake metrics:all
	bundle exec rake code_metrics:stats

	endTime=$(date +%s)
	timeDifference=$(( $endTime - $startTime ))

	echo "Execution time :" $timeDifference
	echo "Finished."

}
#RUN
main
