pipeline {
    agent any
    parameters {
        string(name: 'NXRelease', defaultValue: 'nx2412.latest', description: 'Use the latest IP from NX2412 release to create the build.')
        booleanParam(name: 'SeriesBuild', defaultValue: false, description: 'Enable SeriesRelease when Series release build is required ')
        string(name: 'SeriesName', defaultValue: '0', description: 'Provide the Series name for which you want to build the pipeline. series name format should be like "NX2412_Series.3000".')
        string(name: 'UnitPath', defaultValue: '/apps/JenkinsBase/units/Dev', description: 'Path where build unit for the run is to be created.')
        string(name: 'StagePath', defaultValue: '/apps/JenkinsBase/stage/Dev', description: 'Path where translator worker kits are to be staged.')
        booleanParam(name: 'HC', defaultValue: false, description: 'Enable horizontal collaboration change package ')
        string(name: 'CPNumber', defaultValue: '0', description: 'CP number on top of NXRelease against which build and test steps to be executed.')
        booleanParam(name: 'Deploy', defaultValue: false, description: 'Deploy staging directory contents to customer setup')
    }
    stages {
        stage('Init') {
            steps {
                script {
                    gv = load "ContainerBasedWorkflow.groovy"
                    emailHandle = load "sendEmail.groovy"
                    buildDir = "${params.UnitPath}/${params.NXRelease}_TranslatorWorker_${env.BUILD_TIMESTAMP}"
                    stageDir = "${params.StagePath}/${params.NXRelease}_TranslatorWorker_${env.BUILD_TIMESTAMP}"
                    NXReleaseVersion = "${params.NXRelease}"
                    HCFlag = "${params.HC}"
                    SeriesFlag = "${params.SeriesBuild}"
                }
            }
        }
    }
    post {
        success {
            echo 'All tasks completed successfully.'
        }
        failure {
            echo 'One or more stages have failed.'
        }
        always {
            script {
                emailHandle.sendEmail(buildDir, stageDir, 'linux')
            }
        }
    }
}
