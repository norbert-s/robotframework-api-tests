pipeline {
    agent any
    environment{
        POSTMAN_API_KEY = credentials('POSTMAN_API_KEY')
        //ROBOT_PATH = ${ROBOT_PATH}
    }
    stages {
        stage('Build') {
            steps{
                 bat """C:\\Users\\norbert.susztek\\AppData\\Local\\Programs\\Python\\Python310\\python --version"""

            }
        }
        stage('Execute issuetracker tests') {
            steps{
                bat """C:\\Users\\norbert.susztek\\AppData\\Local\\Programs\\Python\\Python310\\python.exe -m robot.run --pythonpath C:\\Users\\norbert.susztek\\AppData\\Local\\Programs\\Python\\Python310\\Lib\\site-packages -d robot/results -i issuetracker  robot/testfiles/issuetracker.robot"""
                }
        }
        stage('Execute mock tests tests') {
            steps{
                bat """C:\\Users\\norbert.susztek\\AppData\\Local\\Programs\\Python\\Python310\\python.exe -m robot.run --pythonpath C:\\Users\\norbert.susztek\\AppData\\Local\\Programs\\Python\\Python310\\Lib\\site-packages -d robot/results -v api_key_postman:${POSTMAN_API_KEY} robot/testfiles/mock_server_tests_postman.robot"""
                }
        }
    }
}