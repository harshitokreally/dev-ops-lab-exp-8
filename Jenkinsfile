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
                    // Cleanup any existing container with this name before starting
                    bat 'docker rm -f test-container || rem'
                    
                    // Task 6.1: Run the application inside a temporary container
                    // We map it to port 8081 to avoid conflicts with other stages
                    bat 'docker run -d --name test-container -p 8082:80 my-web-app:latest'
                    
                    // Give the container a few seconds to start up
                    sleep 5
                    
                    try {
                        // Task 6.2: Validate the application using an HTTP request (curl)
                        // The -f flag ensures curl returns an error code if the page is not found
                        bat 'curl -f http://localhost:8082'
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
        
        stage('Deploy Dev') {
            steps {
                script {
                    // Cleanup existing Dev container [cite: 43]
                    bat 'docker rm -f dev-container || rem'
                    // Deploy to Dev environment on port 8080 [cite: 43]
                    bat 'docker run -d --name dev-container -p 8080:80 my-web-app:latest'
                    echo "Application deployed to Dev at http://localhost:8080"
                }
            }
        }

        stage('Deploy Prod') {
            steps {
                script {
                    // Cleanup existing Prod container [cite: 45]
                    bat 'docker rm -f prod-container || rem'
                    // Deploy to Prod environment on port 9090 [cite: 45]
                    bat 'docker run -d --name prod-container -p 9090:80 my-web-app:latest'
                    echo "Application deployed to Prod at http://localhost:9090"
                }
            }
        }
    }
}
