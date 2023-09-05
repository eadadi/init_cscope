#!/bin/bash

if [ -z "$1" ]
then
	PROJECT_REPO=`pwd`
	DDIR=$PROJECT_REPO
else
	PROJECT_REPO=$1
	BASE_GIT_ADDR="$HOME/Public/git"
	DDIR="${BASE_GIT_ADDR}/${PROJECT_REPO}" 
fi



#Handle the special case of handling the linux repo
test="linux"
if [[ "$PROJECT_REPO" == "$test" ]];
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
	ctags -R *
	cscope -Rbqk
	echo "Done initializing linux repo"
	exit 0
fi


#Init the tags file and the cscope file
cd $DDIR

find $DDIR  -name '*.c' -o -name '*.h' -o -name '*.py' > $DDIR/cscope.files
ctags -R -L cscope.files
cscope -Rbq -i cscope.files


export CSCOPE_DB=$DDIR/cscope.out
echo "Done initializing. by default, current cscope_db=$CSCOPE_DB"

exit 0

