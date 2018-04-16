pipeline {
  agent {
    label "jenkins-go"
  }
  environment {
    HUGO_VERSION = "0.26"
    GH_CREDS = credentials('jenkins-x-github')
    BUILD_NUMBER = "$BUILD_NUMBER"
    GIT_USERNAME = "$GH_CREDS_USR"
    GIT_API_TOKEN = "$GH_CREDS_PSW"
    GITHUB_ACCESS_TOKEN = "$GH_CREDS_PSW"

    JOB_NAME = "$JOB_NAME"
    BRANCH_NAME = "$BRANCH_NAME"
  }
  stages {
    stage('Regenerate Website') {
      when {
        branch 'master'
      }
      steps {
        checkout scm
        container('go') {
          sh "git clone https://github.com/jenkins-x/jenkins-x-website.git"
          sh "hugo -d jenkins-x-website --enableGitInfo"

          dir("jenkins-x-website") {
            sh "git config credential.helper store"
            sh "git add *"
            sh "git commit --allow-empty -a -m \"updated site\""
            sh "git push origin"
          }
        }
      }
    }
  }
}
