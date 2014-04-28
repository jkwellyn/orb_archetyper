#!/bin/sh

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

	echo  WHICH rvm is `which rvm`
	echo RVM LIST is `rvm list`

	#grab the ruby file
	RUBY_VERSION=`cat RUBY_VERSION`
	echo RUBY_VERSION is \'$RUBY_VERSION\'

	rvm $RUBY_VERSION exec bundle install --path vendor/bundle

	rvm $RUBY_VERSION exec rake spec:full
	rvm $RUBY_VERSION exec rake metrics:all
	rvm $RUBY_VERSION exec rake code_metrics:stats

	endTime=$(date +%s)
	timeDifference=$(( $endTime - $startTime ))

	echo "Execution time :" $timeDifference
	echo "Finished."

}
#RUN
main