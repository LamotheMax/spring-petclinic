pipeline {
	environment{
		skipping = "${sh(script:'./jenkins/scripts/check_commit_age.sh', returnStdout: true)}"
	}
  agent any
  stages {
		stage('build') {
			when{
				branch 'master'
				expression{
					return env.skipping == 'CHECK';
				}
			}
			steps {
			echo env.skipping
			sh 'mvn -B compile'
			}
		}

		stage('test') {
			when{
				branch 'master'
				expression{
					return env.skipping == 'CHECK';
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
					return env.skipping == 'CHECK';
				}
			}
		  steps {
			sh './jenkins/scripts/deliver.sh'
		  }
		}
		
		stage('SKIP MARKER') {
			when{
				branch 'master'
				expression{
					return env.skipping == 'BREAK';
				}
			}
		  steps {
			currentBuild.result = 'ABORTED'
			error('Stopping early...')
		  }
		}
	}
  post{
	success{
		echo 'passed'
	}
	failure{
		sh './jenkins/scripts/bisect.sh'
	}
  }
}