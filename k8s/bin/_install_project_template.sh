#!/bin/bash


base_template="streams-project-bootstrap"
project_config_file="project_config.properties"
template_git_repo="https://github.com/axv0419/${base_template}.git"

echo "###############################################"
echo "# Spring Boot - Kafka - Gradle - GCP Bootstrap"
echo "###############################################"

export BASE_DIR=$(pwd)
echo   "BASE_DIR : $BASE_DIR" 
#Check if project config exists

if [ ! -f ${BASE_DIR}/${project_config_file} ]; then
    echo "Project config file ${project_config_file} missing in current directory"
    echo "Please go through the readme file at  ${template_git_repo} to create it."
    exit 0
fi



echo .
echo "Cloning Template project to /tmp/"
echo .
rm -rf /tmp/${base_template}
git clone ${template_git_repo} /tmp/${base_template}

echo .
echo "Creating ${BASE_DIR}/k8s from template"
echo .



cp -r /tmp/${base_template}/k8s ${BASE_DIR}

source ${BASE_DIR}/${project_config_file} 

cat << EOF > ${BASE_DIR}/k8s/bin/setenv.sh
#!/bin/bash

export KUBE_NAMESPACE=${KUBE_NAMESPACE}
export KUBE_APP_NAME=${KUBE_APP_NAME}
export KUBE_CLUSTER=${KUBE_CLUSTER}
export KUBE_REGION=${KUBE_REGION}

EOF



chmod +x ${BASE_DIR}/k8s/bin/*.sh
# Call Bootstrap script
${BASE_DIR}/k8s/bin/prepare_config.sh

# Obscure /k8s/runtime-config from git checkin
grep -qxF '/k8s/runtime-config' ${BASE_DIR}/.gitignore || echo '/k8s/runtime-config' >> ${BASE_DIR}/.gitignore
