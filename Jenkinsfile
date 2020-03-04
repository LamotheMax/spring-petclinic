pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        sh 'mvn -B'
      }
    }

    stage('test') {
      steps {
        sh 'mvn test'
      }
    }

  }
}