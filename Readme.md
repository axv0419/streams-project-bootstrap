## Kafka Project Template


<img src="./docs/images/DevOps-2.png" style="width:100%" />
__CI in action__


<img src="./docs/images/DevOps-1.png" style="width:100%" />
__CI setup__
Use this project to bootstrap Gradle projects for CI/CD using Google Cloud Build.

>> Use a workspace folder such as  `c:\workspace` on windows or  `~/workspace` on unix

Step 1.


Create a Spring boot project using (Spring Initilizer)[https://start.spring.io/]. Download and expand the generated file to your workspace folder.

This would be your `project folder`

Step 2. 

Create a `project_config.properties` file in your `project folder` with following content.
```bash

# Kubernetes namespace for isolating microservice project resources
KUBE_NAMESPACE=sorrento
# application name
KUBE_APP_NAME=valley-app
# Name of Kubernetes cluster that will host the development instances of the application
KUBE_CLUSTER=kubernetes-p8-integrations-eu-dev-2
# Google Cloud Region where the Kubernetes cluster is located
KUBE_REGION=europe-west3

```
Step 3.

Bootstrap your project
```bash
> cd ~/workspace/{project folder}
> bash <(curl -k -s https://raw.githubusercontent.com/axv0419/streams-project-bootstrap/master/k8s/bin/_install_project_template.sh)

```

Step 4.

Edit project specific application.yaml files for various runtime environments under
`~/workspace/{project folder}/k8s/runtime-config`
This folder is exempt from Git Checkin.  
__NOTE - Avoid putting sensitive configuration in GIT__
