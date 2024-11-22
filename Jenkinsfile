pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'git@github.com:sakibchonka/schedule.git'
            }
        }
        stage('Build') {
            steps {
                sh '''
                xcodebuild -workspace schedule.xcworkspace \
                           -scheme schedule \
                           -sdk iphoneos \
                           build
                '''
            }
        }
        stage('Archive and Export') {
            steps {
                sh '''
                xcodebuild -workspace schedule.xcworkspace \
                           -scheme schedule \
                           archive -archivePath build/schedule.xcarchive
                xcodebuild -exportArchive \
                           -archivePath build/schedule.xcarchive \
                           -exportOptionsPlist ExportOptions.plist \
                           -exportPath build
                '''
            }
        }
    }
    post {
        success {
            archiveArtifacts artifacts: 'build/**/*.ipa', fingerprint: true
            mail to: 'sakibchonka@gmail.com', subject: 'Build Success', body: 'The build succeeded!'
        }
        failure {
            mail to: 'sakibchonka@gmail.com', subject: 'Build Failed', body: 'The build failed. Please check Jenkins.'
        }
    }
}
