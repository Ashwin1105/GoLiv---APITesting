pipeline {
  agent any
  stages {
    stage('Checkout') { steps { checkout scm } }
    stage('Run API Tests') {
      steps {
        script {
          sh 'npm install'
          def exitCode = sh(returnStatus: true, script: 'npx cucumber-js')
          if (exitCode != 0) { currentBuild.result = 'UNSTABLE' }
        }
      }
    }
    stage('Publish Results') {
      steps { junit allowEmptyResults: true, testResults: 'test-results/*.xml' }
    }
  }
  post {
    success { echo "BUILD PASSED — all API tests green." }
    unstable { echo "BUILD UNSTABLE — some API tests failed."; script { currentBuild.result = 'FAILURE' } }
    failure  { echo "BUILD FAILED — check test output above." }
  }
}
