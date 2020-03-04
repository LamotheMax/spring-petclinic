pipeline {
	environment {
		SKIP_STATUS = "${sh(script:'./jenkins/scripts/check_commit_age.sh', returnStdout: true).trim()}"
	}
  agent any
  stages {
  
  		stage('JUST WONDERING') {
			steps {
				echo "${env.SKIP_STATUS}"
				echo "BREAK"
			}
		}
		stage('Fail Early') {
			when{
				branch 'master'
			}
			steps {
				script { currentBuild.result = 'ABORTED'}
				error("FailedEarly WOOT WOOT")
			}
		}
		
		stage('build') {
			when{
				branch 'master'
				expression{
					return ("${env.SKIP_STATUS}").equals("CHECK");
				}
			}
			steps {
			sh 'mvn -B compile'
			}
		}

		stage('test') {
			when{
				branch 'master'
				expression{
					return ("${env.SKIP_STATUS}").equals("CHECK");
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
					return ("${env.SKIP_STATUS}").equals("CHECK");
				}
			}
		  steps {
			sh './jenkins/scripts/deliver.sh'
		  }
		}
	}
	post{
		success{
			echo "passed"
		}
		failure{
			echo "Bisecting"
			sh "./jenkins/scripts/bisect.sh"
		}
  }
}