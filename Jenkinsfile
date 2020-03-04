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
		  steps {
			sh 'mvn test'
		  }
		}

		stage('deliver') {
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
		sh './jenkins/scripts/bisect.sh'
	}
  }
}