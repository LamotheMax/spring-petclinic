
	last_commit="2000a1a47251e2d188454bc87a2356d31dd10de7"
	since_last_success=$(git log $last_commit^..HEAD --pretty=oneline | wc -l)
	echo $since_last_success
	at_least_eight=$(( $since_last_success / 8 ))
	if (( at_least_eight >= 1 ));
	then 
		echo 1;
	else
		echo 0;
	fi;
