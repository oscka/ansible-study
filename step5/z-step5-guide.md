

# step4 
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
