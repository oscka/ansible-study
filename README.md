# ansible-study
2024.03.14 ansible study(남궁상무님) - 교육 진행한 내용입니다.

## 로컬 테스트

로컬 테스트를 위해 다음과 같은 사항이 필요합니다.
- Vagrant, VirtualBox(KVM,Hyper-V 등등) 기반의 2개 가상머진(VM) 구동 필요
- install 서버 : ansible 설치 필요 
- target 서버: vagrant를 통해 구동된 서버에 ssh키/password 없이 접속할 수 있어야 함

vagrant로 구동한 경우 기본적으로 vagrant 계정으로 sudo 권한으로 접근이 가능하나 그렇지 않을 경우 다음과 같은 작업이 필요

비밀번호 없이 SSH로 접속하기

```zsh
# 키 생성(~/.ssh 하위에 생성됨)
ssh-keygen -t rsa
# ssh키 등록
ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@192.168.0.xxx
# 접속 확인
ssh vagrant@192.168.0.xxx
# test
ansible -i hosts-vm all -m ping
```

ssh로 접속시 접속이 안될 경우(permission denieded오류)

```zsh
# 다음 파일의 내용을 수정(PasswordAuthentication항목을 yes로 수정)
vi /etc/ssh/sshd_config
# 이후 ssh데몬을 재기동
sudo service sshd restart
# 다른 서버에서 해당 서버로 password로 ssh접근이 되는지 확인
ssh vagrant@192.168.0.xxx
```

sudo 명령 수행시 비밀번호 없이 접속하기
```zsh
# ssh키 등록
(작성중)
```

vagrant파일 샘플
```
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
      vb.cpus = 2 
      vb.memory = "2040"
  end
end
```
