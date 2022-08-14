pipeline {
    agent any
    environment{
        POSTMAN_API_KEY = credentials('POSTMAN_API_KEY')
        //ROBOT_PATH = ${ROBOT_PATH}
    }
    stages {
        stage('Build') {
            steps{
                 bat "python --version"
            }
        }
        stage('Execute') {
            steps{
                bat """C:\\Users\\norbert.susztek\\AppData\\Local\\Programs\\Python\\Python310robot\\python.exe -m robot.run C:\\Users\\norbert.susztek\\AppData\\Local\\Programs\\Python\\Python310\\Lib\\site-packages -d robot/results -i issuetracker  robot/testfiles/issuetracker.robot"""
                }
        }
    }
}