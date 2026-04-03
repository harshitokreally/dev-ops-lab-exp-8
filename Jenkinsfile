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
        stage('Test') {
            steps {
                script {
                    // Task 6.1: Run the application inside a temporary container
                    // We map it to port 8081 to avoid conflicts with other stages
                    bat 'docker run -d --name test-container -p 8081:80 my-web-app:latest'
                    
                    // Give the container a few seconds to start up
                    sleep 5
                    
                    try {
                        // Task 6.2: Validate the application using an HTTP request (curl)
                        // The -f flag ensures curl returns an error code if the page is not found
                        bat 'curl -f http://localhost:8081'
                        echo "Test Passed: Application is reachable!"
                    } catch (Exception e) {
                        // Task 6.3: Ensure the pipeline stops if the test fails
                        echo "Test Failed: Application is unreachable."
                        error "Pipeline aborted due to test failure."
                    } finally {
                        // Task 6.4: Remove the test container after execution (success or failure)
                        bat 'docker stop test-container'
                        bat 'docker rm test-container'
                    }
                }
            }
        }
    }
}
