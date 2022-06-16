source ~/.cntlm

export KUBECONFIG=/Users/uwu822/.kube/config
export PATH=$PATH:~/go/bin
export GO111MODULE=on
export GONOSUMDB=github.cloud.capitalone.com
export PATH="${PATH}:${HOME}/.krew/bin"
export PATH="${PATH}:${HOME}/go/bin/sonar/bin"
export PATH="${PATH}:${HOME}/Library/Python/3.9/bin"


# Aliases
alias pip='pip3.7'
alias setawsprod="export AWS_PROFILE=GR_GG_COF_AWS_Commercialbank_Prod_ProdSupport && export AWS_DEFAULT_PROFILE=GR_GG_COF_AWS_Commercialbank_Prod_ProdSupport"
alias setawsqa="export AWS_PROFILE=GR_GG_COF_AWS_CommercialBank_QA_Developer && export AWS_DEFAULT_PROFILE=GR_GG_COF_AWS_CommercialBank_QA_Developer"
alias setawsdev="export AWS_PROFILE=GR_GG_COF_AWS_Commercialbank_Dev_Developer && export AWS_DEFAULT_PROFILE=GR_GG_COF_AWS_Commercialbank_Dev_Developer"
alias kutil='kubectl get nodes --no-headers | awk '\''{print $1}'\'' | xargs -I {} sh -c '\''echo {} ; kubectl describe node {} | grep Allocated -A 5 | grep -ve Event -ve Allocated -ve percent -ve -- ; echo '\'''
alias cdgo='cd ~/go/src/github.cloud.capitalone.com/'
alias cddragon='cd ~/go/src/github.cloud.capitalone.com/dragon'
alias cdkustomize='cd ~/go/src/github.cloud.capitalone.com/kustomize-dragon'
alias k='NO_PROXY=.cb4good.com no_proxy=.cb4good.com kubectl'
alias nodes='kubectl get nodes'
alias pods='kubectl get pods'
alias allpods='kubectl get pods --all-namespaces'
alias podtime='kubectl get pods --sort-by=.metadata.creationTimestamp'
alias use="kubectl config use-context"
alias gensts='SecurityTokenScript'
alias bastion=~/.software/bastion.sh
alias reload='source ~/.zprofile'
alias knwatch='watch -n 5 kubectl get nodes --sort-by=.metadata.creationTimestamp'
alias instanceid='/usr/local/bin/get-instance-from-ip.py'
alias psqlcli='kubectl run --rm -it psql-cli --image artifactory.cloud.capitalone.com/vigil/postgres:9.6.5 -- bash;'
alias baddog='kubectl get pods -n datadog | grep "  1   " | awk '\''{ print $1}'\'' | xargs kubectl delete pods -n datadog --grace-period=0 --force'
alias verybaddog='kubectl delete pods -n datadog --all --grace-period=0 --force'
alias pwoxy='cofproxy on'
alias proxyon='brew services start cntlm'
alias proxyoff='brew services stop cntlm'
alias watch='watch '
alias gopen='goland'
alias login='kubectl dragon login'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kc='kubectl config set-context'

# Region Aliases
alias te='kubectl config use-context dragon-toothless-us-east-1'
alias tw='kubectl config use-context dragon-toothless-us-west-2'
alias ppe='kubectl config use-context dragon-preprod-us-east-1'
alias ppw='kubectl config use-context dragon-preprod-us-west-2'
alias pe='kubectl config use-context dragon-prod-us-east-1'
alias pw='kubectl config use-context dragon-prod-us-west-2'

alias aws-tokens="cloudsentry access get --all -f --ba BACMLDRAGON"
alias aws-dragon-dev="cloudsentry access get --account cof-dev-bacmldragon --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_Dev_Developer"
alias aws-dragon-qa="cloudsentry access get --account cof-qa-bacmldragon --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_QA_Developer"
alias aws-dragon-prd="cloudsentry access get --account cof-prd-bacmldragon --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_Prod_ReadOnly"
alias aws-cml-dev="cloudsentry access get --account cof-commercialbank-dev --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_Commercialbank_Dev_Developer"
alias aws-cml-qa="cloudsentry access get --account cof-commercialbank-qa --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_Commercialbank_QA_Developer"
alias aws-cml-prd="cloudsentry access get --account cof-commercialbank-prod bacmldragon --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_Commercialbank_Prod_ReadOnly"
alias killserver="aws ec2 terminate-instances --instance-id"
alias kc="kubectx"
alias kns="kubens"
alias awslocal="aws --endpoint-url https://aws.tk.localhost:8443 --ca-bundle ~/.tk/ca.crt"

paccount(){
   ~/dashAccountCheckout.sh -c "P-UWU822" -d "cof.ds.capitalone.com" -r "${1}" -i "${1}";
}

# ssh-y commands
sphinx-builder () {
	ip=$1
	if [[ $ip == 10.200.* ]]
	then
		echo "@$ip@com-psmp-pl.cloud.capitalone.com"
	elif [[ $ip == 10.184.* ]]
	then
		echo "@$ip@com-psmp-pl-w.cloud.capitalone.com"
	elif [[ $ip == 10.203.* ]] || [[ $ip == 10.205.* ]] || [[ $ip == 10.194.* ]] || [[ $ip == 10.149.* ]]
	then
		echo "@$ip@com-psmp-ql.clouddqt.capitalone.com"
	elif [[ $ip == 10.187.* ]] || [[ $ip == 10.191.* ]]
	then
		echo "@$ip@com-psmp-ql-w.clouddqt.capitalone.com"
	fi
}

assh () {
	echo "Working magic..."
	string=$1
	read num1 num2 num3 num4 num5 <<< ${string//[^0-9]/ }
	1=$num1.$num2.$num3.$num4
	echo "Best guess is $1"
	suffix=$(sphinx-builder "$1")
	sshpass -p "M!$h@Lun@1518!@" ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" "$USER@root$suffix"
}

function rssh() {
  suffix=$(sphinx-builder "$1")
  pass=$(security find-internet-password -s github.kdc.capitalone.com -w)
  sshpass -p $pass ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" "$USER$suffix"
}

function dragonUpstream() {
  sourceRepo=$(git remote get-url origin | sed "s/T-Rex/dragon/g")
  git remote add upstream $sourceRepo
  echo "Upstream remote added: " $(git remote get-url upstream)
}

function ns() {
  namespace=$1
  context=`kubectl config current-context`
  if [ -z $namespace ]
    then
      if [[ $context == *"toothless"* ]]
        then
          namespace="dragon-dev"
      else
        namespace="dragon"
      fi
  fi
  kubectl config set-context --current --namespace=$namespace
}

# generates AWS tokens for eid
function sts(){
    BLAH=`security find-internet-password -s github.kdc.capitalone.com -w`
    gensts -u $USER -p $BLAH
}
# generates AWS tokens for p-eid
function p-sts(){
    BLAH=`security find-internet-password -s p-eid.capitalone.com -w`
    gensts -u p-$USER -p $BLAH
}
# loads p-eid password into the keychain for the p-sts function to use
function load-peid(){
    echo "deleting old p-eid"
    security delete-internet-password -a p-$USER -s "p-eid.capitalone.com" || true
    security add-internet-password -a p-$USER -s "p-eid.capitalone.com" -w "${1}"
    echo "p-eid loaded"
}
function background-tokens(){
    while true; do   sts; sleep 1800; done
}
function background-prod-tokens(){
    while true; do   p-sts; sleep 1800; done
}

if [ -f /usr/local/cof/bin/cofproxy ]                                 #source_cofproxy
  then source /usr/local/cof/bin/cofproxy > /dev/null 2>&1            #source_cofproxy
fi                                                                    #source_cofproxy

function epoch() {
  epoch=$1
  date -r $epoch '+%m/%d/%Y %H:%M:%S'
}

function label () {
	k get nodes -o custom-columns='NAME:.metadata.name,ROLE:.spec.taints[0].value' --no-headers | grep -v "<none>" | awk '{print $1 " node-role.kubernetes.io/" $2 "=\"\"" }' | xargs -I{} sh -c 'kubectl label node {}""'
}

function kexec() {
  if [[ -z "$2" ]];
    then
      kubectl exec -it $1 -- bash
    else
      kubectl exec -it -n $2 $1 -- bash
  fi
}

function start-kragon() {
    if [[ -z "$1" ]];
    then
        echo "a cluster name must be passed to start the cluster"
        return
    fi

    asg=$(aws autoscaling describe-auto-scaling-groups --query "AutoScalingGroups[? Tags[? (Key=='Cluster') && Value=='${1}']]".AutoScalingGroupName)
    echo $asg | jq -r .[] | xargs aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name | jq -r '.AutoScalingGroups[].Instances[].InstanceId' | xargs aws ec2 start-instances --instance-ids

    asg=( $(echo $asg | jq -r .[]) )

    for a in "${asg[@]}";
    do
        echo "removing tags and paused processes"
        aws autoscaling delete-tags --tags ResourceId=${a},ResourceType=auto-scaling-group,Key=custodian_offhours_marker,Value=suspended
        aws autoscaling resume-processes --auto-scaling-group-name ${a} --scaling-process HealthCheck ReplaceUnhealthy AlarmNotification AZRebalance Launch Terminate ScheduledActions AddToLoadBalancer
    done

    echo starting etcd
    etcd=$(aws ec2 describe-instances --filters "Name=tag:Cluster,Values=${1}" "Name=tag:custodian_offhours_marker,Values=stopped" | jq -r '.Reservations[].Instances[].InstanceId')
    aws ec2 delete-tags --resources ${etcd} --tags Key=custodian_offhours_marker
    aws ec2 start-instances --instance-ids ${etcd}

    echo starting cilium etcd
    etcd=$(aws ec2 describe-instances --filters "Name=tag:Cluster,Values=${1}-cilium" "Name=tag:custodian_offhours_marker,Values=stopped" | jq -r '.Reservations[].Instances[].InstanceId')
    aws ec2 delete-tags --resources ${etcd} --tags Key=custodian_offhours_marker
    aws ec2 start-instances --instance-ids ${etcd}
}

function iam-pod() {
    kubectl run --rm -it telnet --overrides="{ \"spec\": { \"template\": { \"metadata\": { \"annotations\": { \"iam.amazonaws.com/role\": \"${1}\" } }, \"spec\": { \"tolerations\": [ { \"effect\": \"NoSchedule\", \"key\": \"dedicated\", \"operator\": \"Equal\", \"value\": \"service\" }, { \"effect\": \"NoExecute\", \"key\": \"dedicated\", \"operator\": \"Equal\", \"value\": \"service\" } ] } } } }" --image artifactory.cloud.capitalone.com/dragon/telnet:latest
}

function nettest-pod() {
    if [[ -z $1 ]]; then
        echo "must pass in a node role"
        return 1
    fi
    if [[ -z $2 ]]; then
        echo "must pass a namespace"
        return 1
    fi
    asv=$(kubectl get ns ${2} -o go-template='{{index .metadata.labels "service.asv" }}')
    kubectl run --rm -it telnet -l service.asv=$asv -n $2 --overrides="{ \"spec\": { \"tolerations\": [ { \"effect\": \"NoSchedule\", \"key\": \"dedicated\", \"operator\": \"Equal\", \"value\": \"$1\" }, { \"effect\": \"NoExecute\", \"key\": \"dedicated\", \"operator\": \"Equal\", \"value\": \"$1\"}]}}" --image artifactory.cloud.capitalone.com/dragon/telnet:latest
}
alias inettest="nettest-pod ingress"
alias jnettest="nettest-pod job"
alias snettest="nettest-pod service"
alias nettest=snettest
function iam-pod() {
    kubectl run --rm -it telnet --overrides="{ \"metadata\": { \"annotations\": { \"iam.amazonaws.com/role\": \"${1}\" } }, \"spec\": { \"tolerations\": [ { \"effect\": \"NoSchedule\", \"key\": \"dedicated\", \"operator\": \"Equal\", \"value\": \"service\" }, { \"effect\": \"NoExecute\", \"key\": \"dedicated\", \"operator\": \"Equal\", \"value\": \"service\" } ] } }" --image artifactory.cloud.capitalone.com/dragon/telnet:latest
}
function node-selector() {
    kubectl run --rm -it telnet --overrides="{ \"spec\": { \"nodeSelector\": { \"kubernetes.io/hostname\": \"${1}\" }, \"tolerations\": [ { \"operator\": \"Exists\" } ] } }" --image artifactory.cloud.capitalone.com/dragon/telnet:latest
}

function instance(){
  stuff=$(NO_PROXY=.cb4good.com no_proxy=.cb4good.com kubectl get node $1 -o yaml | grep "ec2.amazonaws.com/instance-id: i-")
  echo $stuff
  tmp=${stuff#*id: }
  echo $tmp | pbcopy
}

#Kubernetes things
alias sorted="NO_PROXY=.cb4good.com no_proxy=.cb4good.com  kubectl get nodes --sort-by=.metadata.creationTimestamp "
alias drain="NO_PROXY=.cb4good.com no_proxy=.cb4good.com  kubectl drain --ignore-daemonsets --delete-emptydir-data"

function aws-local() {
  export AWS_PROFILE=default
  export AWS_DEFAULT_PROFILE=default
  export AWS_ACCESS_KEY_ID=test
  export AWS_SECRET_ACCESS_KEY=test
}

function does-splunk-work() {                   
  index=$1
  if [ -z $index ]
  then
    echo "argument one must be the index to test"
    return
  fi

  curl -kv https://horizheceastqa.clouddqt.capitalone.com:8089/services/collector/event -H  "Authorization: Splunk e654163a-8fea-4d96-bff3-a2c2aff8bb88" -d "{
    \"time\": `date +%s`.277102,
    \"event\": {
      \"log\": \"dil800 was here again again\",
      \"cluster_environment\": \"local\",
      \"cluster_name\": \"kind\",
      \"region\": \"us-west-2\",
      \"sourcetype\": \"app_log\",
      \"pod_name\": \"elk-test-7977f8fcb4-nlkcp\",
      \"namespace\": \"fluent-bit\",
      \"pod_id\": \"9f21affe-0c96-47c5-8db3-e6f6d7ec8bc9\",
      \"host\": \"fluent-bit-control-plane\",
      \"container_name\": \"elk-test\",
      \"container_hash\": \"artifactory.cloud.capitalone.com/kube-tools/random@sha256:10d85bfcf3a03280943be9bcbf4f94268bf5d9ed8310354704a2d904d47d26aa\",
      \"container_image\": \"artifactory.cloud.capitalone.com/kube-tools/random:alpha\",
      \"testEvent\": \"testing\",
      \"app\": \"elk-test\",
      \"ba\": \"default\",
      \"asv\": \"default\"
    },
    \"index\": \"${index}\"
  }"

  curl -kv https://horizhecwestqa.clouddqt.capitalone.com:8089/services/collector/event -H  "Authorization: Splunk e654163a-8fea-4d96-bff3-a2c2aff8bb88" -d "{
    \"time\": `date +%s`.277103, 
    \"event\": {
      \"log\": \"dil800 was here again again\",
      \"cluster_environment\": \"local\",
      \"cluster_name\": \"kind\",
      \"region\": \"us-east-1\",
      \"sourcetype\": \"app_log\",
      \"pod_name\": \"elk-test-7977f8fcb4-nlkcp\",
      \"namespace\": \"fluent-bit\",
      \"pod_id\": \"9f21affe-0c96-47c5-8db3-e6f6d7ec8bc9\",
      \"host\": \"fluent-bit-control-plane\",
      \"container_name\": \"elk-test\",
      \"container_hash\": \"artifactory.cloud.capitalone.com/kube-tools/random@sha256:10d85bfcf3a03280943be9bcbf4f94268bf5d9ed8310354704a2d904d47d26aa\",
      \"container_image\": \"artifactory.cloud.capitalone.com/kube-tools/random:alpha\",
      \"testEvent\": \"testing\",
      \"app\": \"elk-test\",
      \"ba\": \"default\",
      \"asv\": \"default\"
    },
    \"index\": \"${index}\"
  }"
}

function root-pod() {
    if [[ -z "$1" ]];
    then
        echo "a node name must be passed for use as the node selector"
        return
    fi

    nodeSelector='"nodeSelector": { "kubernetes.io/hostname": "'${1}'" },'
    podName=${USER}-nsenter-${1}

    k run ${podName:?} --restart=Never -it --rm --image overriden --overrides '
    {
      "spec": {
        "hostPID": true,
        "hostNetwork": true,
        '"${nodeSelector?}"'
        "tolerations": [{
            "operator": "Exists"
        }],
        "containers": [
          {
            "name": "nsenter",
            "image": "artifactory-dockerhub.cloud.capitalone.com/alexeiled/nsenter:2.34",
            "command": [
              "/nsenter", "--all", "--target=1", "--", "su", "-"
            ],
            "stdin": true,
            "tty": true,
            "securityContext": {
              "privileged": true
            }
          }
        ]
      }
    }' --attach "$@"
}

function does-new-splunk-work-prod() {
  index=$1
  if [ -z $index ]
  then
    echo "argument one must be the index to test"
    return
  fi

  curl -kv https://psplunkhec.cloud.capitalone.com:8089/services/collector/event -H  "Authorization: Splunk b19ad26d-13ac-4718-9c6c-25b48d1faa4b" -d "{
    \"time\": `date +%s`.277102,
    \"event\": {
      \"log\": \"dil800 was here again again\",
      \"cluster_environment\": \"local\",
      \"cluster_name\": \"kind\",
      \"region\": \"us-east-1\",
      \"sourcetype\": \"app_log\",
      \"pod_name\": \"elk-test-7977f8fcb4-nlkcp\",
      \"namespace\": \"fluent-bit\",
      \"pod_id\": \"9f21affe-0c96-47c5-8db3-e6f6d7ec8bc9\",
      \"host\": \"fluent-bit-control-plane\",
      \"container_name\": \"elk-test\",
      \"container_hash\": \"artifactory.cloud.capitalone.com/kube-tools/random@sha256:10d85bfcf3a03280943be9bcbf4f94268bf5d9ed8310354704a2d904d47d26aa\",
      \"container_image\": \"artifactory.cloud.capitalone.com/kube-tools/random:alpha\",
      \"testEvent\": \"testing\",
      \"app\": \"elk-test\",
      \"ba\": \"default\",
      \"asv\": \"default\"
    },
    \"index\": \"${index}\"
  }"

}

get-dragon-token () {
	token=`kubectl -n "$1" get secrets | awk '{print $1}' | grep "dragon-jenkins-deploy-token-"`
	kubectl -n "$1" get secrets "$token" -o json | jq -r .data.token | base64 --decode | pbcopy
}

pwoxy

clear
