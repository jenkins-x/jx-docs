pipeline {
  agent any
  environment {
    HUGO_VERSION = "0.26"
    BUILD_NUMBER = "$BUILD_NUMBER"

    GH_CREDS            = credentials('jx-pipeline-git-github-github')
    GHE_CREDS           = credentials('jx-pipeline-git-github-ghe')
    GIT_USERNAME = "$GH_CREDS_USR"	
    GIT_API_TOKEN = "$GH_CREDS_PSW"	
    GITHUB_ACCESS_TOKEN = "$GH_CREDS_PSW"

    JOB_NAME = "$JOB_NAME"
    BRANCH_NAME = "$BRANCH_NAME"
  }
  stages {
    stage('CI Validate') {
      when {
        branch 'PR-*'
      }
      steps {
        sh "git clone https://github.com/jenkins-x/jx-docs.git"
        dir("jx-docs") {
          sh "git fetch origin pull/$PULL_NUMBER/head:$BRANCH_NAME"
          sh "git checkout $PULL_PULL_SHA"
          
          sh "hugo version"
          sh "hugo -d tmp-website --enableGitInfo"
        }
      }
    }

    stage('Regenerate Website') {
      when {
        branch 'master'
      }
      steps {
        sh "git clone https://github.com/jenkins-x/jx-docs.git"
        dir("jx-docs") {
          sh "git clone https://github.com/jenkins-x/jenkins-x-website.git"
          sh "hugo version"
          sh "hugo -d jenkins-x-website --enableGitInfo"

          dir("jenkins-x-website") {
            sh "jx step git credentials"
            sh 'git config credential.helper store'
            sh 'git add *'
            sh "git commit --allow-empty -a -m \"updated site\""
            sh "git push origin"
          }
        }
      }
    }
  }
}
