pipeline {
  agent any
  stages {
  		stage('JUST WONDERING') {
			steps {
				echo needsBisect().toString()
				echo "BREAK"
			}
		}
		stage('Fail Early') {
			when{
				branch 'master'
				expression{
					return (needsBisect() == 0);
				}
			}
			steps {
				script { 
					currentBuild.result = 'ABORTED'
				}
				error("FailedEarly WOOT WOOT")
			}
		}
		
		stage('build') {
			when{
				branch 'master'
				expression{
					return (needsBisect() == 1);
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
					return (needsBisect() == 1);
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
					return (needsBisect() == 1);
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
		return 1;
	}
	
	since_last_success=sh (script:"git log ${last_good_commit}^..HEAD --pretty=oneline | wc -l", returnStdout: true).trim();
	at_least=sh (script:"echo \$((${since_last_success} >= 8))", returnStdout: true).trim();
	
	if (at_least.toInteger() == 1){
		return 1;
		}
	else{
		return 0;
	}
}