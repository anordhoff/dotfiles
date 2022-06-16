PATH=/usr/local/bin/:$PATH:~/.software/:/Users/dil800/Library/Python/2.7/bin/:~/go/bin/:/Users/dil800/Library/Python/3.7/bin:/Users/dil800/.krew/bin/

export HISTCONTROL=ignorespace
export GOPATH=~/go/
export GONOSUMDB=github.cloud.capitalone.com
export GOPRIVATE=*.cloud.capitalone.com
export GOPROXY=https://artifactory.cloud.capitalone.com/artifactory/api/go/go-shared

alias watch='watch '
alias history='history 0'

# change dirs
alias projects="cd ~/projects/"
alias dragon="cd ~/go/src/github.cloud.capitalone.com/dragon/"

# aws crap
alias setawsdev="export AWS_PROFILE=GR_GG_COF_AWS_Commercialbank_Dev_Developer"
alias setawsqa="export AWS_PROFILE=GR_GG_COF_AWS_CommercialBank_QA_Developer"
alias setawsprod="export AWS_PROFILE=GR_GG_COF_AWS_Commercialbank_Prod_ProdSupport"
alias setawsdragondev="export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_Dev_Developer"
alias setawsdragonqa="export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_QA_Developer"
alias setawsdragonprod="export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_Prod_ProdSupport"
alias killserver="aws ec2 terminate-instances --instance-id"
alias east="export AWS_REGION=us-east-1"
alias west="export AWS_REGION=us-west-2"
export AWS_PROFILE=GR_GG_COF_AWS_Commercialbank_Dev_Developer

ec2 () {
    nameTag=$1
    if [ -z $nameTag ]
    then
        echo "argument one must be the instance names"
        return
    fi
    aws ec2 describe-instances --filters "Name=tag:Name,Values=${nameTag}*" --query 'sort_by(Reservations[*].Instances[*].{LaunchTime:LaunchTime, InstanceID:InstanceId, ImageId:ImageId, IP:PrivateIpAddress, State:State.Name, Name:Tags[?Key==`Name`] | [0].Value}[], &LaunchTime)' --output table | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} -v terminated
}

function start-kragon() {
    if [[ -z "$1" ]];
    then
        echo "a cluster name must be passed to start the cluster"
        return
    fi
    if [[ "$2" ]];
    then
        echo "setting region"
        export AWS_REGION=$2
        export AWS_DEFAULT_REGION=$2
    fi

    echo starting etcd
    etcd=$(aws ec2 describe-instances --filters "Name=tag:Cluster,Values=${1}" "Name=tag:custodian_offhours_marker,Values=stopped" | jq '[.Reservations[].Instances[].InstanceId] | join(",")')
    aws ec2 delete-tags --resources "[\"${etcd}\"]" --tags Key=custodian_offhours_marker
    aws ec2 start-instances --instance-ids "[\"${etcd}\"]"

    echo starting cilium etcd
    etcd=$(aws ec2 describe-instances --filters "Name=tag:Cluster,Values=${1}-cilium" "Name=tag:custodian_offhours_marker,Values=stopped" | jq -r '[.Reservations[].Instances[].InstanceId] | join("\", \"")')
    aws ec2 delete-tags --resources "[\"${etcd}\"]" --tags Key=custodian_offhours_marker
    aws ec2 start-instances --instance-ids "[\"${etcd}\"]"

    asg=$(aws autoscaling describe-auto-scaling-groups --query "AutoScalingGroups[? Tags[? (Key=='Cluster') && Value=='${1}']]".AutoScalingGroupName)
    echo $asg | jq -r '.[]' | xargs aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name | jq -r '.AutoScalingGroups[].Instances[].InstanceId' | xargs aws ec2 start-instances --instance-ids

    asg=( $(echo $asg | jq -r '.[]') )

    for a in "${asg[@]}";
    do
        echo "removing tags and paused processes for ${a}"
        aws autoscaling delete-tags --tags ResourceId=${a},ResourceType=auto-scaling-group,Key=custodian_offhours_marker,Value=suspended
        aws autoscaling resume-processes --auto-scaling-group-name ${a} --scaling-process HealthCheck ReplaceUnhealthy AlarmNotification AZRebalance Launch Terminate ScheduledActions AddToLoadBalancer
    done
}

describe-image () {
	image=$1
	if [ -z $image ]
	then
		echo "You must supply an image id (e.g. ami-0cdca04ab0b6c8b72)"
	fi
	echo "Describing AMI ${image}"
	aws ec2 describe-images --image-id ${image} --output table
}

bucket-size () {
	bucket=$1
	if [ -z $bucket ]
	then
		bucket=cmlcof-hubble-dragon-preprod-us-east-1
	fi
	aws s3 ls --summarize --human-readable --recursive s3://$bucket
}

alias aws-tokens="cloudsentry access get --all -f --ba BACMLDRAGON"
alias aws-dragon-dev="cloudsentry access get --account cof-dev-bacmldragon --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_Dev_Developer"
alias aws-dragon-qa="cloudsentry access get --account cof-qa-bacmldragon --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_QA_Developer"
alias aws-dragon-pcd="cloudsentry access get --account cof-pcd-bacmldragon --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_PreCDE_Developer"
alias aws-dragon-prd="cloudsentry access get --account cof-prd-bacmldragon --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_Prod_ReadOnly"
alias aws-dragon-prd-co="cloudsentry access get --account cof-prd-bacmldragon --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_Prod_ProdSupport"
alias aws-cml-dev="cloudsentry access get --account cof-commercialbank-dev --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_Commercialbank_Dev_Developer"
alias aws-cml-qa="cloudsentry access get --account cof-commercialbank-qa --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_CommercialBank_QA_Developer"
alias aws-cml-prd="cloudsentry access get --account cof-commercialbank-prod bacmldragon --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_Commercialbank_Prod_ReadOnly"
alias aws-cml-prd-co="cloudsentry access get --account cof-commercialbank-prod bacmldragon --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_Commercialbank_Prod_ProdSupport"

function ashort() {
    echo 'alias add="cloudsentry access get --account cof-dev-bacmldragon --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_Dev_Developer"'
    echo 'alias adq="cloudsentry access get --account cof-qa-bacmldragon --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_QA_Developer"'
    echo 'alias adpcde="cloudsentry access get --account cof-pcd-bacmldragon --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_PreCDE_Developer"'
    echo 'alias adp="cloudsentry access get --account cof-prd-bacmldragon --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_Prod_ReadOnly"'
    echo 'alias adpc="export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_Prod_ProdSupport && cloudsentry access get --account cof-prd-bacmldragon --ba BACMLDRAGON --access-id "'
    echo 'alias acd="cloudsentry access get --account cof-commercialbank-dev --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_Commercialbank_Dev_Developer"'
    echo 'alias acq="cloudsentry access get --account cof-commercialbank-qa --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_CommercialBank_QA_Developer"'
    echo 'alias acp="cloudsentry access get --account cof-commercialbank-prod bacmldragon --ba BACMLDRAGON && export AWS_PROFILE=GR_GG_COF_AWS_Commercialbank_Prod_ReadOnly"'
    echo 'alias acpc="export AWS_PROFILE=GR_GG_COF_AWS_Commercialbank_Prod_ProdSupport && cloudsentry access get --account cof-commercialbank-prod --ba BACMLDRAGON --access-id "'
    echo 'alias sacd="export AWS_PROFILE=GR_GG_COF_AWS_Commercialbank_Dev_Developer"'
    echo 'alias sacq="export AWS_PROFILE=GR_GG_COF_AWS_CommercialBank_QA_Developer"'
    echo 'alias sacp="export AWS_PROFILE=GR_GG_COF_AWS_Commercialbank_Prod_ProdSupport"'
    echo 'alias sadd="export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_Dev_Developer"'
    echo 'alias sadq="export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_QA_Developer"'
    echo 'alias sadp="export AWS_PROFILE=GR_GG_COF_AWS_BACMLDRAGON_Prod_ProdSupport"'
}
eval `ashort`

function()

# kube stuff
function kshort() {
    echo 'alias k="NO_PROXY=.cb4good.com kubectl"'
    echo 'alias kd="k describe"'
    echo 'alias kg="k get"'
    echo 'alias kgy="k get -o yaml"'
    echo 'alias kgp="k get pods"'
    echo 'alias kdp="k describe pods"'
    echo 'alias kdelp="k delete pods"'
    echo 'alias ke="k edit"'
    echo 'alias kgnst="k get nodes --sort-by metadata.creationTimestamp"'
    echo 'alias watchnodes="watch -n 15 NO_PROXY=.cb4good.com kubectl get nodes --sort-by metadata.creationTimestamp"'
}
eval `kshort`
alias k8shealth='k get nodes --no-headers | awk '\''{print $1}'\'' | xargs -I {} sh -c '\''echo {} ; kubectl describe node {} | grep Allocated -A 5 | grep -ve Event -ve Allocated -ve percent -ve -- ; echo '\'''
alias master-nettest="k run --rm -n kube-system -l service.asv=asvcmldragon -it telnet --overrides='{ \"spec\": { \"tolerations\": [ { \"effect\": \"NoSchedule\", \"key\": \"node-role.kubernetes.io/master\" }]}}' --image artifactory.cloud.capitalone.com/dragon/telnet:latest"
alias baddog='k get pods -n datadog | grep -v "  0    " | awk '\''{ print $1}'\'' | xargs kubectl delete pods -n datadog --grace-period=0 --force'
alias delete-not-ready="k get nodes | grep NotReady | awk '{ print $1 }' | xargs kubectl delete nodes"
alias te="k dragon login --context=dragon-toothless-us-east-1"
alias tw="k dragon login --context=dragon-toothless-us-west-2"
alias ppe="k dragon login --context=dragon-preprod-us-east-1"
alias ppw="k dragon login --context=dragon-preprod-us-west-2"
alias pe="k dragon login --context=dragon-prod-us-east-1"
alias pw="k dragon login --context=dragon-prod-us-west-2"
alias cte="k config use dragon-toothless-us-east-1"
alias ctw="k config use dragon-toothless-us-west-2"
alias cppe="k config use dragon-preprod-us-east-1"
alias cppw="k config use dragon-preprod-us-west-2"
alias cpe="k config use dragon-prod-us-east-1"
alias cpw="k config use dragon-prod-us-west-2"

alias drain="NO_PROXY=.cb4good.com no_proxy=.cb4good.com  kubectl drain --ignore-daemonsets --delete-emptydir-data"
instance(){
  stuff=$(NO_PROXY=.cb4good.com no_proxy=.cb4good.com kubectl get node $1 -o yaml | grep "ec2.amazonaws.com/instance-id: i-")
  tmp=${stuff#*id: }
  echo $tmp
}
function shoot(){
( set -e
  drain $1
  id=$(instance $1)
  echo ${id} # in case proxy pukes
  killserver $id 
  kubectl delete node $1
  echo "it ded"
)
if [ $? -ne 0 ]; then
    printf "shit's broke\x21\nexit 1"
fi
}


function label-nodes() {
    k get nodes -o custom-columns='NAME:.metadata.name,ROLE:.spec.taints[0].value' --no-headers | grep -v "<none>" | awk '{print $1 " node-role.kubernetes.io/" $2 "=\"\"" }' | xargs -I{} sh -c 'NO_PROXY=.cb4good.com kubectl label node {}""'
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

function hubble-pod() {
    kubectl run --rm -it hubble-cli -n cilium --env="HUBBLE_DEFAULT_SOCKET_PATH=hubble-relay:80" --overrides="{ \"spec\": { \"tolerations\": [ { \"effect\": \"NoSchedule\", \"key\": \"dedicated\", \"operator\": \"Equal\", \"value\": \"service\" }, { \"effect\": \"NoExecute\", \"key\": \"dedicated\", \"operator\": \"Equal\", \"value\": \"service\" } ] } }" --image artifactory-quay.cloud.capitalone.com/isovalent/hubble:v1.8.5-cee.1 --command=true -- bash
}

function kragon-pod() {
    if [[ -z $1 ]]; then
      echo "must pass an IAM Role"
      return 1
    fi
    if [[ -z $2 ]]; then
      echo "must pass a Kragon version"
      return 1
    fi
    kubectl run -it kragon --overrides="{ \"metadata\": { \"annotations\": { \"iam.amazonaws.com/role\": \"${1}\" } }, \"spec\": { \"tolerations\": [ { \"effect\": \"NoSchedule\", \"key\": \"dedicated\", \"operator\": \"Equal\", \"value\": \"service\" }, { \"effect\": \"NoExecute\", \"key\": \"dedicated\", \"operator\": \"Equal\", \"value\": \"service\" } ] } }" --image artifactory.cloud.capitalone.com/dragon/kragon:${2}
}

function node-selector() {
    kubectl run --rm -it telnet --overrides="{ \"spec\": { \"nodeSelector\": { \"kubernetes.io/hostname\": \"${1}\" }, \"tolerations\": [ { \"operator\": \"Exists\" } ] } }" --image artifactory.cloud.capitalone.com/dragon/telnet:latest
}

function kns() {
  kubectl config set-context --current --namespace=${1}
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
            "image": "artifactory-dockerhub.cloud.capitalone.com/alexeiled/nsenter:2.38",
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

alias dmqs="k get secrets dmq -o json | jq -r '.data.connection_string' | base64 --decode"
function natstest() {
  kubectl run \
  --rm --attach --restart Never \
  --overrides='{ "spec": { "tolerations": [ { "effect": "NoSchedule", "key": "dedicated", "operator": "Equal", "value": "service" }, { "effect": "NoExecute", "key": "dedicated", "operator": "Equal", "value": "service"}]}}' \
  --image artifactory.cloud.capitalone.com/dragon/nats-bench:latest --env server=$(dmqs) nats-bench
}

function onefleet() {
	if [[ -z "$1" ]];
	then
		echo "a grep search string is required"; return
	fi
	no_proxy=.cb4good.com kubectl get node -o custom-columns="NAME:.metadata.name,ID:.metadata.annotations.ec2\.amazonaws\.com/instance-id,TYPE:.metadata.labels.dragon\.cloud\.capitalone\.com/role" | grep -E "$1"
}

autoload -Uz compinit
compinit
source <(kubectl completion zsh)
complete -F __start_kubectl k

# legacy proxy attempts
alias setproxy='printf "Enter EID: " && read EID && printf "Enter password: " && read -s PASSWORD && export HTTP_PROXY=$(printf "%q" "http://$EID:$PASSWORD@entproxy.kdc.capitalone.com:8099") && export HTTPS_PROXY=$(printf "%q" "http://$EID:$PASSWORD@entproxy.kdc.capitalone.com:8099") && echo'

# git stuff
function gshort() {
    echo 'alias gpum="git pull upstream master"'
    echo 'alias gpull="git pull"'
    echo 'alias gc="git commit -m"'
    echo 'alias gp="git push"'
    echo 'alias gpo="git push -u origin `git branch --show-current`"'
    echo 'alias gs="git status"'
    echo 'alias ga="git add"'
    echo 'alias gd="git diff"'
    echo 'alias gm="git checkout main"'
    echo 'alias gml="git checkout master"'
    echo 'alias dpr="hub pull-request --base dragon:master -p "'
    echo 'alias kdpr="hub pull-request --base kustomize-dragon:master -p "'
    echo 'alias hprs="hub pr show"'
}
eval `gshort`

# p-eid
function paccount(){
   dashAccountCheckout.py --account "P-dil800" -d "cof.ds.capitalone.com" -r "${1}" --ticket "${1}";
}

# ssh-y commands
function sphinx-builder() {
  ip=$1

  if [[ $ip == 10.200.* ]] ; then
    echo "@$ip@com-psmp-pl.cloud.capitalone.com"
  elif [[ $ip == 10.184.* ]] || [[ $ip == 10.134.* ]]; then
    echo "@$ip@com-psmp-pl-w.cloud.capitalone.com"
  elif [[ $ip == 10.203.* ]] || [[ $ip == 10.205.* ]] || [[ $ip == 10.194.* ]] || [[ $ip == 10.149.* ]] || [[ $ip == 10.159.* ]] || [[ $ip == 10.21* ]]; then
    echo "@$ip@com-psmp-ql.clouddqt.capitalone.com"
  elif [[ $ip == 10.187.* ]] || [[ $ip == 10.191.* ]] ; then
    echo "@$ip@com-psmp-ql-w.clouddqt.capitalone.com"
  fi
}

function assh() {
  suffix=$(sphinx-builder "$1")
  ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" "$USER@root$suffix"
}

function rssh() {
  suffix=$(sphinx-builder "$1")
  ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" "$USER$suffix"
}

function bastion() {
  ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" bastion$1
}

function epoch() {
  date -r $(echo $1 | sed 's/\..*//g')
}

function jpl-work() {
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
  unset JAVA_TOOL_OPTIONS
}

devex () {
	if [[ "$1" == "p" ]]
	then
		api="api"
	else
		api="api-it"
	fi
	echo "Using $api..."
	echo "client"
	read clientid
	echo "secret"
	read secret
	curl --location --silent --request POST "https://$api.cloud.capitalone.com/oauth2/token" --header 'cache-control: no-cache' --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode "client_id=$clientid" --data-urlencode "client_secret=$secret" --data-urlencode 'grant_type=client_credentials' | jq .access_token -r | pbcopy
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

  curl -kv https://horizhecwestqa.clouddqt.capitalone.com:8089/services/collector/event -H  "Authorization: Splunk e654163a-8fea-4d96-bff3-a2c2aff8bb88" -d "{
    \"time\": `date +%s`.277103, 
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
}


function does-splunk-work-prod() {                   
  index=$1
  if [ -z $index ]
  then
    echo "argument one must be the index to test"
    return
  fi

  curl -kv https://horizheceast.cloud.capitalone.com:8089/services/collector/event -H  "Authorization: Splunk b19ad26d-13ac-4718-9c6c-25b48d1faa4b" -d "{
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

  curl -kv https://horizhecwest.cloud.capitalone.com:8089/services/collector/event -H  "Authorization: Splunk b19ad26d-13ac-4718-9c6c-25b48d1faa4b" -d "{
    \"time\": `date +%s`.277103, 
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
}

#LDAP THANGS
whodis () {
	id=$1
	if [ -z $id ]
	then
		echo "must supply an eID"
	fi
    pass=$(security find-internet-password -s github.cloud.capitalone.com -w)
	ldapsearch -H ldap://cof.ds.capitalone.com -D "${USER}@cof.ds.capitalone.com" -b "dc=cof,dc=ds,dc=capitalone,dc=com" -w "${pass}" -LLL "sAMAccountName=$1" | grep -e "displayName\|title"
}
whoall() {
  id=$1
	if [ -z $id ]
	then
		echo "must supply a group name"
	fi
    pass=$(security find-internet-password -s github.cloud.capitalone.com -w)
  ldapsearch -H ldap://cof.ds.capitalone.com -D "${USER}@cof.ds.capitalone.com" -b 'dc=cof,dc=ds,dc=capitalone,dc=com' -w "${pass}" -LLL "sAMAccountName=$1" | grep "member" | awk -F'[=,]' '{ print $2 }'
}

#entkops things
export ENTKOPS_VERSION=3.1.0
export CLUSTER_BASE=~/cluster/fleet/kops-testing
export CLUSTER_NAME='cos-testing.cof-dev-bacmldragon.aws.cb4good.com'
alias entkops='docker run -it \
  -v ${CLUSTER_BASE}:${CLUSTER_BASE} \
  -v ${HOME}/.kube:/enterprise-kops/.kube \
  -v ${HOME}/.aws:/enterprise-kops/.aws \
  -v ${HOME}/.argocd:/enterprise-kops/.argocd \
  -e ALL_PROXY=$https_proxy \
  -e all_proxy=$https_proxy \
  -e HTTPS_PROXY=$https_proxy \
  -e https_proxy=$https_proxy \
  -e HTTP_PROXY=$https_proxy \
  -e http_proxy=$https_proxy \
  -e NO_PROXY=$no_proxy \
  -e no_proxy=$no_proxy \
  -e USERNAME=$USERNAME \
  -e AWS_PROFILE=$AWS_PROFILE \
  -e LDAP_BIND_DN=$LDAP_BIND_DN \
  -e LDAP_BIND_PW=$LDAP_BIND_PW \
  -e DATADOG_API_KEY=$DATADOG_API_KEY \
  -e DATADOG_APP_KEY=$DATADOG_APP_KEY \
  -e DEVEX_CLIENT_ID=$DEVEX_CLIENT_ID \
  -e DEVEX_CLIENT_SECRET=$DEVEX_CLIENT_SECRET \
  -e LOCKBOX_ID=$LOCKBOX_ID \
  -e PIPELINES_STATE_STORE=$PIPELINES_STATE_STORE \
  -e PIPELINES_STATE_STORE_REGION=$PIPELINES_STATE_STORE_REGION \
  -e VAULT_APPROLE_SECRET_NONPROD=$VAULT_APPROLE_SECRET_NONPROD \
  -e JENKINS_USERNAME=$JENKINS_USERNAME \
  -e JENKINS_PASSWORD=$JENKINS_PASSWORD \
  -e CLUSTER_BASE=$CLUSTER_BASE \
  -e CLUSTER_NAME=$CLUSTER_NAME \
  artifactory.cloud.capitalone.com/enterprise-kops/enterprise-kops:${ENTKOPS_VERSION}'

function get-dragon-token() {
  token=`kubectl -n "$1" get secrets | awk '{print $1}' | grep "dragon-jenkins-deploy-token-"`
  kubectl -n "$1" get secrets "$token" -o json | jq -r .data.token | base64 --decode | pbcopy
}

b4 () {
	echo $1 | base64 --decode
}

# automatically added things

if [ -f /usr/local/cof/bin/cofproxy ]                                 #source_cofproxy
  then source /usr/local/cof/bin/cofproxy > /dev/null 2>&1            #source_cofproxy
fi
cofproxy dev
#sts >&/dev/null &

# goenv tool setup.
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"

# Setting PATH for Python 3.7
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH
