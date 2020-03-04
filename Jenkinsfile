pipeline {
	environment {
		SKIP_STATUS = "${sh(script:'./jenkins/scripts/check_commit_age.sh', returnStdout: true)}"
	}
  agent any
  stages {
  
		stage('Fail Early') {
			when{
				branch 'master'
				expression{
					return "${env.SKIP_STATUS}".equals("BREAK\n");
				}
			}
			steps {
				error('Failed early')
			}
		}
		
		stage('build') {
			when{
				branch 'master'
				expression{
					return "${env.SKIP_STATUS}".equals("CHECK\n");
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
					return "${env.SKIP_STATUS}".equals("CHECK\n");
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
					return "${env.SKIP_STATUS}".equals("CHECK\n");
				}
			}
		  steps {
			sh './jenkins/scripts/deliver.sh'
		  }
		}
	}
}