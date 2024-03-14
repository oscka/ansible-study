


# step3  Ansible Role 로 관리  



## ansible role 생성
```
ansible-galaxy init  test-role
```

//host 확인 
//export ANSIBLE_HOST_KEY_CHECKING=False
// sudo vim /etc/ansible/ansible.cfg
ansible -i hosts-vm  all -m ping 

ansible-playbook -i hosts-vm  playbook-step3.yml   -t "pre, k8s-basic" 


```
