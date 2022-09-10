Ответ:
1-3. Файл создан: my_new_module.py, заполнен и отредактирован
4. Локальный тест выполнен: 
nonstop@umbrella:~/devops-projects/myrepo/8_ansible/ansible_rep/ansible $ python -m ansible.modules.my_new_module input.json

{"invocation": {"module_args": {"content": "some data \nmulti line", "path": "/tmp/test.txt"}}, "message": "file was written", "changed": true, "original_message": "some data \nmulti line"}

nonstop@umbrella: ~/devops-projects/myrepo/8_ansible/ansible_rep/ansible $ cat /tmp/test.txt
some data 
multi line
nonstop@umbrella: ~/devops-projects/myrepo/8_ansible/ansible_rep/ansible $ 


5-6. проверка  playbook
nonstop@umbrella:~/devops-projects/myrepo/8_ansible/ansible_rep/ansible $ ansible-playbook test_pb.yml 
[WARNING]: You are running the development version of Ansible. You should only run
Ansible from "devel" if you are modifying the Ansible engine, or trying out features
under development. This is a rapidly changing source of code and can become unstable at
any point.
[WARNING]: provided hosts list is empty, only localhost is available. Note that the
implicit localhost does not match 'all'
[WARNING]: ansible.utils.display.initialize_locale has not been called, this may result
in incorrectly calculated text widths that can cause Display to print incorrect line
lengths

PLAY [test my module] *******************************************************************

TASK [Gathering Facts] ******************************************************************
ok: [localhost]

TASK [run my module] ********************************************************************
changed: [localhost]

TASK [dump test_out] ********************************************************************
ok: [localhost] => {
    "msg": {
        "changed": true,
        "failed": false,
        "message": "file was written",
        "original_message": "some new content"
    }
}

PLAY RECAP ******************************************************************************
localhost                  : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   


Проверка на идемпотентность
nonstop@umbrella:~/devops-projects/myrepo/8_ansible/ansible_rep/ansible $ ansible-playbook test_pb.yml 
[WARNING]: You are running the development version of Ansible. You should only run Ansible from "devel"
if you are modifying the Ansible engine, or trying out features under development. This is a rapidly
changing source of code and can become unstable at any point.
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost
does not match 'all'
[WARNING]: ansible.utils.display.initialize_locale has not been called, this may result in incorrectly
calculated text widths that can cause Display to print incorrect line lengths

PLAY [test my module] **********************************************************************************

TASK [Gathering Facts] *********************************************************************************
ok: [localhost]

TASK [run my module] ***********************************************************************************
ok: [localhost]

TASK [dump test_out] ***********************************************************************************
ok: [localhost] => {
    "msg": {
        "changed": false,
        "failed": false,
        "message": "file was written",
        "original_message": "some new content"
    }
}

PLAY RECAP *********************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   



7. выход из окружения
nonstop@umbrella:~/devops-projects/myrepo/8_ansible/ansible_rep/ansible $  deactivate

8-11. Роль создана, запущена + идемпотентность

nonstop@umbrella:~/devops-projects/myrepo/8_ansible/1 $ ansible-galaxy collection init my_netology.my_collection
- Collection my_netology.my_collection was created successfully

nonstop@umbrella:~/devops-projects/myrepo/8_ansible/1 $ ansible-playbook site2.yml
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost
does not match 'all'

PLAY [localhost] ***************************************************************************************

TASK [Gathering Facts] *********************************************************************************
ok: [localhost]

TASK [myrole : run my module] **************************************************************************
changed: [localhost]

PLAY RECAP *********************************************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   


nonstop@umbrella:~/devops-projects/myrepo/8_ansible/1 $ ansible-playbook site2.yml
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost
does not match 'all'

PLAY [localhost] ***************************************************************************************

TASK [Gathering Facts] *********************************************************************************
ok: [localhost]

TASK [myrole : run my module] **************************************************************************
ok: [localhost]

PLAY RECAP *********************************************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

nonstop@umbrella:~/devops-projects/myrepo/8_ansible/1 $ 


12-13. Коллекция заведена создана
nonstop@umbrella:~/devops-projects/myrepo/8_ansible/my_collection/my_netology/my_collection $ ansible-galaxy collection build
Created collection for my_netology.my_collection at /home/nonstop/devops-projects/myrepo/8_ansible/my_collection/my_netology/my_collection/my_netology-my_collection-1.0.0.tar.gz


14-16. Запуск Playbook из коллекции
nonstop@umbrella:~/devops-projects/myrepo/8_ansible/1 $ ansible-playbook site.yml
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost
does not match 'all'

PLAY [test my module] **********************************************************************************

TASK [Gathering Facts] *********************************************************************************
ok: [localhost]

TASK [run my module] ***********************************************************************************
ok: [localhost]

TASK [dump test_out] ***********************************************************************************
ok: [localhost] => {
    "msg": {
        "changed": false,
        "failed": false,
        "message": "file exists",
        "original_message": "some new content"
    }
}

PLAY RECAP *********************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   


nonstop@umbrella:~/devops-projects/myrepo/8_ansible/1 $ tree
.
├── collections
│   └── ansible_collections
│       └── my_netology
│           └── my_collection
│               ├── docs
│               ├── FILES.json
│               ├── MANIFEST.json
│               ├── plugins
│               │   ├── modules
│               │   │   └── my_new_module.py
│               │   └── README.md
│               ├── README.md
│               └── roles
│                   ├── defaults
│                   │   └── main.yml
│                   ├── handlers
│                   │   └── main.yml
│                   ├── meta
│                   │   └── main.yml
│                   ├── tasks
│                   │   └── main.yml
│                   └── vars
│                       └── main.yml
├── group_vars
│   └── all
│       └── vars.yml
├── inventory
│   └── prod.yml
├── my_netology-my_collection-1.0.0.tar.gz
├── site2.yml
└── site.yml

nonstop@umbrella:~/devops-projects/myrepo/8_ansible/1 $ cat site.yml 
---
  - name: test my module
    hosts: localhost
    tasks:
    - name  : run my module
      my_netology.my_collection.my_new_module:
        path: "/tmp/file.txt"
        content: "some new content"
      register: test_out
    - name: dump test_out
      debug:
        msg: "{{ test_out }}"  
