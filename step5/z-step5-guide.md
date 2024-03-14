

# step5
- ansible module
- helm
- helm add repository
- kubectl
- k9s
- argocd cli
- k3s kubernetes
- ingress-nginx Controller
- argocd
- prometheus-stack


- facts
- debug/ template/ helm

## install collection
```
ansible-galaxy collection install kubernetes.core
```
##  port open
```
443, 6443
```


## ping 테스트 
```
cd playbooks

sh show-ping-test.sh
```
## tags로 실행 
```
sh run-vm.sh "pre, ansible-module, helm-repo, k8s-basic,k3s, ingress-nginx, argocd"
```
## ingress
- https://argocd.192.168.41.30.sslip.io/

- http://simple-fe.192.168.41.30.sslip.io/hello ## /simple


## 주의사항

```yaml
## test-role하위의 main.yml의 다음 내용 환경에 맞게 수정필요
#LOCAL_USER_HOME: "/Users/blackstar"
LOCAL_USER_HOME: "/home/계정명"
## dev-k3s.yml 파일의 내용을 수정
##mac에서는 아래와 같이 실행하나 이외 환경에서는 ''를 삭제해야 함  
##sed -i '' 's/127.0.0.1/{{ansible_host}}/' {{LOCAL_USER_HOME}}/.kube/config
sed -i 's/127.0.0.1/{{ansible_host}}/' {{LOCAL_USER_HOME}}/.kube/config
```