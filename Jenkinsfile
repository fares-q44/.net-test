pipeline {
    agent any
    
    environment {
        // Define your GitHub repository and the local workspace path
        GIT_REPO = 'https://github.com/adamajammary/simple-web-app-mvc-dotnet'
        LOCAL_WORKSPACE = '/Users/fares/.jenkins/workspace/build-dotnet'
        BUILD_OUTPUT_DIR = 'bin'
        PUBLISH_OUTPUT_DIR = '/Users/fares/Jenkins/2' 
    }
    
    stages {
        stage('Clone Repository') {
            steps {
                // Clone the GitHub repository to the local workspace
                git branch: 'master', url: "${GIT_REPO}"
            }
        }
        
        stage('Build .NET Project') {
            steps {
                script {
                    // Change to the repository directory
                    dir("${LOCAL_WORKSPACE}") {
                        // Build the .NET project
                        sh "dotnet build"
                    }
                }
            }
        }
        stage ('Run SonarQube Scanner'){
            steps{
                script{
                   dir("${LOCAL_WORKSPACE}") {
                       withSonarQubeEnv('test') 
                  {
                      sh "SonarScanner.MSBuild.exe begin /k: \"Test\" /d:sonar.host.url=\"http://localhost:9000\" /d:sonar.token=\"sqp_43cc3939e74a9dc08e7c5ea55f45152570e71162\""
                      sh "MsBuild.exe /t:Rebuild"
                      sh "SonarScanner.MSBuild.exe end /d:sonar.token=\"sqp_43cc3939e74a9dc08e7c5ea55f45152570e71162\""
                  }
                    } 
                }
            }
        }
        stage('Publish .NET Application') {
            steps {
                script {
                    // Change to the repository directory
                    dir("${LOCAL_WORKSPACE}") {
                        // Publish the .NET application
                        sh "dotnet publish -c Release -o ${PUBLISH_OUTPUT_DIR}"
                    }
                }
            }
        }
    }
   post {
        always {
            // Clean unnecessary directories, but keep the BUILD_OUTPUT_DIR and PUBLISH_OUTPUT_DIR
            cleanWs() 
            }
    }

 }
