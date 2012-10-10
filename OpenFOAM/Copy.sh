
export FOAM_RUN=run

if test -d run
then
	echo "" &> /dev/null
else
	mkdir run

	cp -r $FOAM_TUTORIALS run
fi
