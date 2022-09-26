node{
    
    def maven = tool name: "Maven"
    
    echo "Jenkins Job Name: ${env.JOB_NAME}"
    
    echo "Jenkins Job Url: ${env.JOB_URL}"
    
    echo "Jenkins Build URL: ${env.BUILD_URL}"
    
    properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '5', numToKeepStr: '3')), pipelineTriggers([pollSCM('* * * * *')])])
    
    
    try{
       
       slackNotifications('Started')
       
       //Checkout SCM
    stage('Checkout from Git')
    {
     git branch: 'development', credentialsId: '034672a4-2c42-46e2-956c-12b44d44a50e', url: 'https://github.com/Home-Practice/StudentRegistrationForm.git'
    }
   
   //Maven Build
   stage('Maven Build')
   {
       sh "${maven}/bin/mvn clean package"
   }
   
   //Sonar Quality Gates
   stage('Sonar Quality Analysis')
   {
       sh "${maven}/bin/mvn sonar:sonar"
   }
   
   //Upload Artifact into Nexus Repository
   stage('Upload Nexus Artifact')
   {
       sh "${maven}/bin/mvn clean deploy"
   }
   
   //Deploy to Tomcat
   stage('Deploy to Tomcat')
   {
       sshagent(['88191867-5e68-4aa8-8f94-552256f9af2a']) {
           
           sh "scp -o StrictHostKeyChecking=no target/*.war ec2-user@172.31.32.53:/opt/apache-tomcat-8.5.82/webapps/"
           
    
       }
   }

        
    }  //try block end
    catch(e)
    {
      slackNotifications(currentBuild.result)
      throw e   
    } //catch block end
    finally{
        slackNotifications(currentBuild.result)
    } //finally block end
} //node close

    def slackNotifications(String buildStatus = 'STARTED') {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESSFUL'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL})"

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  // Send notifications
  slackSend (color: colorCode, message: summary)
} //slack notifications end
    
    
