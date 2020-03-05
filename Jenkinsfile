pipeline {
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
	last_good_commit= (env.GIT_PREVIOUS_SUCCESSFUL_COMMIT);
	if (last_good_commit != null){
		last_good_commit= (env.GIT_PREVIOUS_SUCCESSFUL_COMMIT).trim();
		}
	else{
		return 0;
	}
	
	since_last_success=sh (script:"git log ${last_good_commit}^..HEAD --pretty=oneline | wc -l", returnStdout: true).trim();
	at_least_eight=(( since_last_success / 8 ))
	if (at_least_eight.greaterThanOrEqualTo(1)){
		return 1;
		}
	else{
		return 0;
	}
}