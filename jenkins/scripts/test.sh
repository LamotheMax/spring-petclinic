
	last_commit="e385f761de27293b38bb8aad8b8df3f3a0db8d4d"
	since_last_success=$(git log $last_commit^..HEAD --pretty=oneline | wc -l)
	at_least_eight=$(( $since_last_success / 8 ))
	if (( at_least_eight >= 1 ));
	then 
		echo 1;
	else
		echo 0;
	fi;
