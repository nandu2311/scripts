Create IAM Role for Windows Server

Create Role

Select EC2

add the below policies
a) CloudWatchAgentServerPolicy
b) CloudWatchAgentAdminPolicy
c) AmazonSSMManagedInstanceCore

Click Next

Provide the role name: 
Click on Create Role



EC2 Instance (Windows Server)
instance name: Windows
Instance type: t2.medium
add the iam role above created 
and launch the instance


login the ec2 instance





Systems Manager Console // Run Command // AWS-ConfigureAWSPackage 
Name box // AmazonCloudWatchAgent

cd 'C:\Program Files\Amazon\AmazonCloudWatchAgent'
./amazon-cloudwatch-agent-config-wizard.exe

212212141122111111
=========================================================

System Manager Console // Run Command // AmazonCloudWatch-ManageAgent
Optional Configuration Location // AmazonCloudWatch-windows




Others Steps to Install Cloudwatch Agent in Windows Servers

Login Ec2 Windows Server with RDP

# and Download the file from below code from browser
https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi

# After Download install the above application

# then open cd 'C:\Program Files\Amazon\AmazonCloudWatchAgent'

# Run the below command
amazon-cloudwatch-agent-config-wizard.exe


& "C:\Program Files\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1" -a fetch-config -m ec2 -s -c file:"C:\Program Files\Amazon\AmazonCloudWatchAgent\config.json"