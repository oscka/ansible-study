


## VM1/VM2 서버에 docker, kubectl, k9s 설치하기

###  tag를 활용한 Task실행 

```
//host 확인 

ansible -i hosts-vm  all -m ping 

ansible-playbook -i hosts-vm playbook-step2.yml -t "pre , docker,kubectl, k9s"

ansible-playbook -i hosts-vm playbook-step2.yml --list-tags --list-tasks


```

## docker 설치 예제 
//필수 패키지 설치 
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

//GPG Key 인증
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

//docker repository 등록
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

//apt docker 설치
sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io

//docker 확인 
sudo docker -v

//시스템 부팅시 docker가 시작
sudo systemctl enable docker 

//docker engine 기동 
sudo service docker start

//사용자를 docker group에 포함
sudo usermod -a -G docker $USER

//시스템 재기동후 docker ps로 확인 한다 
sudo reboot
```