pipeline{
    
/*echo "Job Name: ${env.JOB_NAME}"
    
    echo "Build No: ${env.BUILD_NUMBER}"
    
    echo "Job URL: ${env.JOB_URL}"
    
    echo "Jenkins URL: ${env.JENKINS_URL}"
*/    
    
   agent any
    
    tools
    {
        maven 'Maven'
    }
    
    options 
    {
      timestamps()
      buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '3')
    }
    
    triggers 
    {
      pollSCM '* * * * *'
    }

    //Stages
    stages
    {
        
        //Git Checkout
        stage('Checkout SCM')
        {
            steps
            {
                  slackNotifications('Started')
                  git credentialsId: '034672a4-2c42-46e2-956c-12b44d44a50e', url: 'https://github.com/Home-Practice/StudentRegistrationForm.git'
            }
        }
        
        //Maven Build
        stage('Maven Build')
        {
            steps
            {
                 sh "mvn clean package"
            }
        }
        
        //Sonarqube
        stage('Sonar Quality')
        {
            steps
            {
                sh "mvn sonar:sonar"
            }
        }
        
        //Upload Artifact into Nexus
        stage('Nexus Artifact')
        {
            steps
            {
                sh "mvn clean deploy"
            }
        }
        
        //Deploy to Tomcat
        stage('Tomcat')
        {
            steps
            {
                sshagent(['e91e8edd-798b-452c-a313-a0b5d7097d49']) 
                {
                  sh "scp -o StrictHostKeyChecking=no target/*.war ec2-user@172.31.32.53:/opt/apache-tomcat-8.5.82/webapps/"
                
                    
                }
            }
        }
    } //Stages End
    
    post 
    {
     success 
     {
        slackNotifications(currentBuild.result)
     }
     failure 
     {
        slackNotifications(currentBuild.result)
     }
    }

    
} //Pipeline END

//Below is the Slack Notifications Code

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
} 

