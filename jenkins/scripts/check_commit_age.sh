TOTAL_COMMITS=$(git rev-list --count HEAD)


modulo=$((TOTAL_COMMITS % 8))

if (( $modulo < 1 ))
then
	echo CHECK
else
	echo BREAK
fi
