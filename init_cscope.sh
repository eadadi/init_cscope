#!/bin/bash

#Handle the special case of handling the linux repo
if [[ "$1" == "linux" ]];
then
	echo "Initializing linux repo..."
	find $DDIR \
		-path "$DDIR/arch*" -prune -o \
		-path "$DDIR/sound" -prune -o \
		-path "$DDIR/Documentation" -prune -o \
		-path "$DDIR/LICENCES" -prune -o \
		-path "$DDIR/drivers" -prune -o \
		-name "*.[ch]" > $DDIR/cscope.files
	cd $DDIR
	ctags-universal -R *
	cscope -Rbqk
	echo "Done initializing linux repo"
	exit 0
fi

find . \
	-path '*/part-support' -prune -o \
	-name '*.[ch]' -o -name '*.py' -o -name '*.cc'\
	> `pwd`/cscope.files
ctags-universal -L cscope.files
cscope -Rbq


export CSCOPE_DB=cscope.out
echo "Done initializing. by default, current cscope_db=$CSCOPE_DB"

exit 0

