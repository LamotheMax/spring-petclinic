pipeline {
	environment{
		skipping = "${sh(script:'./jenkins/scripts/check_commit_age.sh', returnStdout: true)}"
	}
  agent any
  stages {

		stage('Fail Early') {
			when{
				branch 'master'
				expression{
					return (${env.skipping}).equals("BREAK");
				}
			}
		  steps {
				urrentBuild.result = 'ABORTED'
				error('Stopping early...')
		  }
		}
		
		stage('build') {
			when{
				branch 'master'
				expression{
					return (${env.skipping}).equals("CHECK");
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
					return (${env.skipping}).equals("CHECK");
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
					return (${env.skipping}).equals("CHECK");
				}
			}
		  steps {
			sh './jenkins/scripts/deliver.sh'
		  }
		}
	}
  post{
	success{
		echo 'passed'
	}
	failure{
		echo('Bisecting')
		sh './jenkins/scripts/bisect.sh'
	}
	
  }
}