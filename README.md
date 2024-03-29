# ansible-study

2024.03에 진행한 ansible study(남궁상무님) - 교육 진행한 내용입니다.

7개의 handson step으로 이루어져 있으며, 1~6단계는 VM하나를 대상으로 각각의 k8s 솔루션 및 환경들을 설치하고 7단계에서는 6개의 VM(1lb,3master,2worker)에 rancher cluster를 설치합니다.

아래의 실행가이드와 트러블슈팅을 참고하며, 각 step에 있는 z-guide를 참고하여 실행할 수 있습니다.

- [step1](./step1/z-guide.md)
- [step2](./step2/z-guide.md)
- [step3](./step3/z-guide.md)
- [step4](./step4/z-step4-guide.md)
- [step5](./step5/z-step5-guide.md)
- [step6](./step6/z-step6-guide.md)
- [step7](./step7/z-step7-guide.md)

## 실행 준비하기

로컬 테스트를 위해 다음과 같은 사항이 필요합니다.
- Vagrant, VirtualBox(KVM,Hyper-V 등등) 기반의 2개 가상머진(VM) 구동 필요
- install 서버 : ansible 설치 필요 
- target 서버: vagrant를 통해 구동된 서버에 ssh키/password 없이 접속할 수 있어야 함(install서버 -> target서버)

vagrant로 구동한 경우 기본적으로 vagrant 계정으로 sudo 권한으로 접근이 가능하고 ssh권한을 부여하여 주지만, 그렇지 않을 경우 다음과 같은 작업이 필요(단순히 vagrant를 이용해 로컬에서 가상머신을 생성한 경우 필요 없는 작업들임)

### 비밀번호 없이 SSH로 접속하기

```zsh
# 키 생성(~/.ssh 하위에 생성됨) - install서버에서 한번만 수행
ssh-keygen -t rsa
# ssh키 등록 - install서버에서 target서버로 공개키를 등록
ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@192.168.0.xxx
# 접속 확인 - install서버에서 target서버로 비밀번호 없이 접속됨
ssh vagrant@192.168.0.xxx
# test
ansible -i hosts-vm all -m ping
```

### vagrant로 생성된 VM에 ssh로 접속시 접속이 안될 경우(permission denieded오류)

```zsh
# 해당 서버에 vagrant ssh로 접속하여 아래 명령을 수행합니다.
# 다음 파일의 내용을 수정(PasswordAuthentication항목을 yes로 수정)
vi /etc/ssh/sshd_config
# 이후 ssh데몬을 재기동
sudo service ssh restart
# 다른 서버에서 해당 서버로 password로 ssh접근이 되는지 확인
ssh vagrant@192.168.0.xxx
```

### sudo 명령 수행시 비밀번호 없이 접속하기

ansible을 통해 시스템에 설치 등의 작업을 수행하기 위해 sudo 권한이 필요하며 ubuntu에서는 다음과 같이 권한을 줍니다.

```zsh
# /etc/sudoers 파일 맨아래에 다음 내용을 추가
- (사용자명) ALL=NOPASSWD: ALL
# 또는 echo 명령어를 사용하여 추가할 수 있습니다.
- echo '(사용자명) ALL=NOPASSWD: ALL' >> /etc/sudoers
```

### vagrant파일 샘플

```
## hostname과 ip는 여러대를 실행할 경우 각각 다르게 지정해야 함
## cpu, memory는 적당한 갯수를 넣어줍니다.
VMHOSTNAME="test-vm1"
VMIP="192.168.56.10"   

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.hostname = VMHOSTNAME
  config.vm.network :private_network, ip: VMIP 
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
      vb.gui = false
      vb.name = VMHOSTNAME
      vb.cpus = 4 
      vb.memory = "4096"
  end
end
```

## ansible 실행가이드

### 환경에 따라 수정할 부분

실행을 테스트하기 위해 각각 다음과 같은 부분들은 로컬 환경에 맞게 수정하여야 합니다.

#### 인벤토리 정보

각 step의 target서버 정보를 가진 인벤토리 정보파일(hosts-vm)을 환경에 맞게 수정합니다.
(대상서버에 로그인할 수 있는 private key파일을 맞게 넣어주어야 합니다.)

#### LOCAL_USER_HOME 변수값

각 step의 다음 상태경로(defaults/main.yml)하위에 있는 다음 경로를 install서버의 홈 경로로 수정합니다.

```yaml
## test-role하위의 main.yml의 다음 내용 환경에 맞게 수정필요
#LOCAL_USER_HOME: "/Users/blackstar"
LOCAL_USER_HOME: "/home/계정명"
```

#### sed 옵션 수정

mac과 linux에서 sed명령의 parameter가 달라 환경에 따라 수정해야 합니다.

```yaml
## dev-k3s.yml 파일의 내용을 수정
##mac에서는 아래와 같이 실행하나 Linux에서는 ''를 삭제해야 함
##on mac  
##sed -i '' 's/127.0.0.1/{{ansible_host}}/' {{LOCAL_USER_HOME}}/.kube/config
##on linux
sed -i 's/127.0.0.1/{{ansible_host}}/' {{LOCAL_USER_HOME}}/.kube/config
```


### 자주쓰는 ansible 명령

```zsh
#host 확인 
ansible -i hosts-vm all --list-hosts
#접속 테스트 
ansible -i hosts-vm all -m ping 
ansible -i hosts-vm vm1 -m ping
#모든 태그 확인
ansible-playbook playbook-rke2-cluster.yml -i hosts-vm --list-tags
# 미리 작성된 shell을 통한 태그를 통한 일부 task만 실행
sh run-vm.sh "pre, ansible-module, helm-repo, k8s-basic,k3s, ingress-nginx, argocd, app-deploy , prometheus-stack"
```
