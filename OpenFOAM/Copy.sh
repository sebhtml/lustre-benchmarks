

if test -d tutorials
then
	echo "" &> /dev/null
else
	cp -r $FOAM_TUTORIALS .
fi
