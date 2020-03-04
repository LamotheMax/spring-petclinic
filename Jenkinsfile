pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        sh '''VAR=$(./jenkins/scripts/check_commit_age.sh)

if [ $VAR == CHECK ]
then
mvn -B compile
fi'''
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
}