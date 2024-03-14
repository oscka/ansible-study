

# step4 
- ansible module
- helm
- helm add repository
- docker 
- kubectl
- k9s
- argocd cli
- k3ㄴ kubernetes
- ingress-nginx Controller
- argocd


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

