pipeline {
	environment{
		skipping = "${sh(script:'./jenkins/scripts/check_commit_age.sh', returnStdout: true)}"
	}
  agent any
  stages {

		stage('Fail Early') {
			if( (env.BRANCH_NAME == 'master') && (${env.skipping}).equals("BREAK")){
				currentBuild.result = 'ABORTED'
				error('Stopping early...')
			}
			steps{
				sh 'echo test'
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