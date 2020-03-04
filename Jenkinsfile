pipeline {
	environment {
		SKIP_STATUS = "${sh(script:'./jenkins/scripts/check_commit_age.sh', returnStdout: true).trim()}"
	}
  agent any
  stages {
  		stage('JUST WONDERING') {
			steps {
				echo needsBisect()
				echo "BREAK"
			}
		}
		stage('Fail Early') {
			when{
				branch 'master'
			}
			steps {
				script { 
				
				if (needsBisect() == 1){
				currentBuild.result = 'ABORTED'
				
				}
				}
				error("FailedEarly WOOT WOOT")
			}
		}
		
		stage('build') {
			when{
				branch 'master'
				expression{
					return (needsBisect() == 0);
				}
			}
			steps {
			script{
				sh 'mvn -B compile'
			}
			}
		}

		stage('test') {
			when{
				branch 'master'
				expression{
					return (needsBisect() == 0);
				}
			}
		  steps {
			sh 'mvn test'
		  }
		}

		stage('deliver') {
			when{
				branch 'master'
				expression{
					return (needsBisect() == 0);
				}
			}
		  steps {
			sh './jenkins/scripts/deliver.sh'
		  }
		}
	}
}

def needsBisect(){
	echo env.GIT_PREVIOUS_SUCCESSFUL_COMMIT
	last_commit= ${env.GIT_PREVIOUS_SUCCESSFUL_COMMIT}.trim()
	since_last_success=sh (script:'git log ${last_commit}^..HEAD --pretty=oneline | wc -l', returnStdout: true).trim()
	at_least_eight=$(( $since_last_success / 8 ))
	if (at_least_eight.greaterThanOrEqualTo(1)){
		echo 1;
		}
	else{
		echo 0;
	}
}