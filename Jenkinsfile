pipeline {
  agent any
  // NO top-level tools{} block — that resolves BEFORE any stage runs, so a
  // Jenkins instance with no "Maven" tool configured fails immediately at
  // pipeline startup with a Groovy compile error, before Checkout even
  // happens. Real bug hit live: this exact top-level tools{} block was
  // already found and removed from the UI-testing Jenkinsfile back on
  // 2026-08-09 for the identical reason, but that fix was never propagated
  // to this API-testing template. Resolved dynamically inside the stage
  // instead, same pattern as the UI-testing Jenkinsfile's Java branch.
  stages {
    stage('Checkout') { steps { checkout scm } }
    stage('Run API Tests') {
      steps { script {
        def mvnHome = tool name: 'Maven', type: 'maven' // Jenkins → Manage Jenkins → Tools needs a Maven install named "Maven"
        withEnv(["PATH+MAVEN=${mvnHome}/bin"]) {
          // returnStatus, never thrown — a real test failure must not skip
          // Publish Results (same fix as the main UI-testing Jenkinsfile: a
          // throwing sh step here made Jenkins skip "Publish Results"
          // entirely the moment any test failed, so a report never got
          // published and the failure looked identical to a build that never
          // ran anything at all).
          def exitCode = sh(returnStatus: true, script: "mvn -B test -DbaseUrl=http://host.docker.internal:5179")
          if (exitCode != 0) { currentBuild.result = 'UNSTABLE' }
        }
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
