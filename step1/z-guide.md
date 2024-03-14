## VM1 서버에 kubectl 설치하기 

```
//host 확인 
ansible -i hosts-vm all --list-hosts
ansible -i hosts-vm  all -m ping 
ansible -i hosts-vm  vm1 -m ping


vm에서 먼저  kubectl --help 확인 

ansible-playbook -i hosts-vm playbook-step1.yml

ansible-playbook -i hosts-vm playbook-step1.yml -e HOSTS=study-vm

vm에서 설치후   kubectl --help 확인 
```