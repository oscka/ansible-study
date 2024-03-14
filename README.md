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
# ssh키 등록
ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@192.168.0.xxx
# 접속 확인
ssh vagrant@192.168.0.xxx
# test
ansible -i hosts-vm all -m ping
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
