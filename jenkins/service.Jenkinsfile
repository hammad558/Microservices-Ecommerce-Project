// Per-service pipeline. This exact file sits on each service branch; the
// only thing that differs is the branch name, which Jenkins supplies.
// Build -> scan -> push. Tag = git SHA so a deployed pod maps to a commit.

pipeline {
    agent any

    options { timestamps(); disableConcurrentBuilds() }

    environment {
        DOCKERHUB_USER = 'hammad558'
        SERVICE        = "${env.BRANCH_NAME}"
        IMAGE          = "${DOCKERHUB_USER}/${SERVICE}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                script { env.TAG = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim() }
            }
        }

        stage('Build') {
            steps {
                dir('src') {
                    sh 'docker build -t "$IMAGE:$TAG" -t "$IMAGE:latest" .'
                }
            }
        }

        stage('Scan') {
            steps {
                sh 'trivy image --severity CRITICAL --ignore-unfixed --exit-code 1 "$IMAGE:$TAG"'
            }
        }

        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred',
                                                  usernameVariable: 'DH_USER', passwordVariable: 'DH_PASS')]) {
                    sh '''
                      echo "$DH_PASS" | docker login -u "$DH_USER" --password-stdin
                      docker push "$IMAGE:$TAG"
                      docker push "$IMAGE:latest"
                      docker logout
                    '''
                }
            }
        }
    }

    post {
        always { sh 'docker image prune -f || true' }
    }
}
