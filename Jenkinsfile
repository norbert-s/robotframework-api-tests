pipeline {
    agent any
    environment{
        POSTMAN_API_KEY = credentials('POSTMAN_API_KEY')
        ROBOT_PATH = ${ROBOT_PATH}
    }
    stages {

        stage('Execute') {
            steps{
                bat """${ROBOT_PATH}robot -d robot/results -i issuetracker  robot/testfiles/issuetracker.robot"""
            }
        }
    }
}