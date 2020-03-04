pipeline {
	environment {
		SKIP_STATUS = "${sh(script:'./jenkins/scripts/check_commit_age.sh', returnStdout: true)}"
	}
  agent any
  stages {
  
  		stage('Fail Early') {
			steps {
				echo "${env.SKIP_STATUS}"
				echo "BREAK\n"
			}
		}
		
		stage('build') {
			when{
				branch 'master'
				expression{
					return "${env.SKIP_STATUS}".equals("CHECK");
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
					return "${env.SKIP_STATUS}".equals("CHECK");
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
					return "${env.SKIP_STATUS}".equals("CHECK");
				}
			}
		  steps {
			sh './jenkins/scripts/deliver.sh'
		  }
		}
	}
}