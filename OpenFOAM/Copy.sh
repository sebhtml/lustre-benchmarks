#!/bin/bash

export FOAM_RUN=run

if test -d run
then
	echo "" &> /dev/null
else
	mkdir Storage/run

	cp -r $FOAM_TUTORIALS Storage/run

	ln -s Storage/run
fi
