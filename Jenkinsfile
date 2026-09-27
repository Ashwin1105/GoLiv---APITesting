pipeline {
  agent any
  tools { maven 'Maven' } // Jenkins → Manage Jenkins → Tools needs a Maven install named "Maven"
  stages {
    stage('Checkout') { steps { checkout scm } }
    stage('Run API Tests') {
      steps { script {
        // returnStatus, never thrown — a real test failure must not skip
        // Publish Results (same fix as the main UI-testing Jenkinsfile: a
        // throwing sh step here made Jenkins skip "Publish Results"
        // entirely the moment any test failed, so a report never got
        // published and the failure looked identical to a build that never
        // ran anything at all).
        def exitCode = sh(returnStatus: true, script: "mvn -B test -DbaseUrl=http://host.docker.internal:5179")
        if (exitCode != 0) { currentBuild.result = 'UNSTABLE' }
      } }
    }
    stage('Publish Results') {
      steps { junit allowEmptyResults: true, testResults: 'target/surefire-reports/*.xml' }
    }
  }
  post {
    success { echo "BUILD PASSED — all API tests green." }
    unstable { echo "BUILD UNSTABLE — some API tests failed."; script { currentBuild.result = 'FAILURE' } }
    failure  { echo "BUILD FAILED — check test output above." }
  }
}
