pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                // Task 5.1: Clone the repository 
                // Jenkins performs this automatically when using "Pipeline from SCM"
                checkout scm 
                
                // Task 5.2: Build a Docker image using Windows Batch [cite: 31]
                script {
                    bat 'docker build -t my-web-app:latest .' 
                }
            }
        }
    }
}
