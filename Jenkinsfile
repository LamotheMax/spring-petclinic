pipeline {
  agent any
  stages {
    stage('build') {
      steps {
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
}