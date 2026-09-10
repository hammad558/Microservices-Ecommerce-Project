// Deploy job (main branch). Applies the manifests to EKS and waits for every
// rollout to finish, so a broken image fails the build instead of silently
// leaving crash-looping pods behind.

pipeline {
    agent any

    options { timestamps(); disableConcurrentBuilds() }

    environment {
        NAMESPACE   = 'webapps'
        AWS_REGION  = 'us-east-1'
        CLUSTER     = 'online-boutique'
    }

    stages {
        stage('Checkout') {
            steps { checkout scm }
        }

        stage('Kubeconfig') {
            steps {
                // The Jenkins host's instance role has an EKS access entry; no static kube token.
                sh 'aws eks update-kubeconfig --name "$CLUSTER" --region "$AWS_REGION"'
            }
        }

        stage('Apply manifests') {
            steps {
                sh '''
                  kubectl apply -f k8s/namespace.yaml
                  kubectl apply -n "$NAMESPACE" -f k8s/
                '''
            }
        }

        stage('Wait for rollouts') {
            steps {
                sh '''
                  for d in $(kubectl -n "$NAMESPACE" get deploy -o name); do
                    kubectl -n "$NAMESPACE" rollout status "$d" --timeout=180s
                  done
                  kubectl -n "$NAMESPACE" get svc frontend-external
                '''
            }
        }
    }
}
