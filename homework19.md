## 1. Приготовьте свой собственный inventory файл prod.yml.
    ---
      elasticsearch:
        hosts:
          elastic001:
            ansible_connection: docker
      kibana:
        hosts:
          kibana001:
            ansible_connection: docker

 ## 2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает kibana.

Сделано

 ## 3. При создании tasks рекомендую использовать модули: get_url, template, unarchive, file.
 ## 4. Tasks должны: скачать нужной версии дистрибутив, выполнить распаковку в выбранную директорию, сгенерировать конфигурацию с параметрами.

  - name: Install kibana
    hosts: kibana
    tasks:
      - name: Upload tar.gz kibana from remote URL
        get_url:
          url: "https://artifacts.elastic.co/downloads/kibana/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
          dest: "/tmp/kibana-{{ elastic_version }}-linux-x86_64.tar.gz"
          mode: 0755
          timeout: 60
          force: true
          validate_certs: false
        register: get_kibana
        until: get_kibana is succeeded
        tags: kibana
      - name: Create directrory for kibana
        file:
          state: directory
          path: "{{ kibana_home }}"
        tags: kibana
      - name: Extract Kibana in the installation directory
        #become: true
        unarchive:
          copy: false
          src: "/tmp/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
          dest: "{{ kibana_home }}"
          extra_opts: [--strip-components=1]
          creates: "{{ kibana_home }}/bin/kibana"
        tags:
          - skip_ansible_lint
          - kibana
      - name: Set environment Kibana
        #become: true
        template:
          src: templates/kib.sh.j2
          dest: /etc/profile.d/kib.sh
        tags: kibana
        
 ## 5. Запустите ansible-lint site.yml и исправьте ошибки, если они есть.
Ошибки отсутствовали

19:35:01 nonstop@umbrella:~/devops-ansible/2$ ansible-lint site.yml -vvv
Examining site.yml of type playbook


 ## 6. Попробуйте запустить playbook на этом окружении с флагом --check.

1:05:00 nonstop@umbrella:~/devops-ansible/2$ ansible-playbook -i inventory/prod.yml site.yml --check

PLAY [Install Java] ****************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************
ok: [elastic001]
ok: [kibana001]

TASK [Set facts for Java 8 vars] ***************************************************************************************************************
ok: [elastic001]
ok: [kibana001]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************************************
changed: [kibana001]
changed: [elastic001]

TASK [Ensure installation dir exists] **********************************************************************************************************
changed: [elastic001]
changed: [kibana001]

TASK [Extract java in the installation directory] **********************************************************************************************
fatal: [elastic001]: FAILED! => {"changed": false, "msg": "dest '/opt/jdk/11.0.11' must be an existing dir"}
fatal: [kibana001]: FAILED! => {"changed": false, "msg": "dest '/opt/jdk/11.0.11' must be an existing dir"}

PLAY RECAP *************************************************************************************************************************************
elastic001                 : ok=4    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
kibana001                  : ok=4    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   



 ## 7. Запустите playbook на prod.yml окружении с флагом --diff. Убедитесь, что изменения на системе произведены.

21:08:47 nonstop@umbrella:~/devops-ansible/2$ ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Java] ****************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************
ok: [elastic001]
ok: [kibana001]

TASK [Set facts for Java 8 vars] ***************************************************************************************************************
ok: [elastic001]
ok: [kibana001]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************************************
diff skipped: source file size is greater than 104448
changed: [kibana001]
diff skipped: source file size is greater than 104448
changed: [elastic001]

TASK [Ensure installation dir exists] **********************************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/jdk/11.0.11",
-    "state": "absent"
+    "state": "directory"
 }

changed: [kibana001]
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/jdk/11.0.11",
-    "state": "absent"
+    "state": "directory"
 }

changed: [elastic001]

TASK [Extract java in the installation directory] **********************************************************************************************
changed: [elastic001]
changed: [kibana001]

TASK [Export environment variables] ************************************************************************************************************
--- before
+++ after: /home/nonstop/.ansible/tmp/ansible-local-221239khw7w2m_/tmp_hy3d13m/jdk.sh.j2
@@ -0,0 +1,5 @@
+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
+#!/usr/bin/env bash
+
+export JAVA_HOME=/opt/jdk/11.0.11
+export PATH=$PATH:$JAVA_HOME/bin
\ No newline at end of file

changed: [kibana001]
--- before
+++ after: /home/nonstop/.ansible/tmp/ansible-local-221239khw7w2m_/tmpgb0gs20t/jdk.sh.j2
@@ -0,0 +1,5 @@
+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
+#!/usr/bin/env bash
+
+export JAVA_HOME=/opt/jdk/11.0.11
+export PATH=$PATH:$JAVA_HOME/bin
\ No newline at end of file

changed: [elastic001]

PLAY [Install Elasticsearch] *******************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************
ok: [elastic001]

TASK [Upload tar.gz Elasticsearch from remote URL] *********************************************************************************************
changed: [elastic001]

TASK [Create directrory for Elasticsearch] *****************************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/elastic/7.10.1",
-    "state": "absent"
+    "state": "directory"
 }

changed: [elastic001]

TASK [Extract Elasticsearch in the installation directory] *************************************************************************************
changed: [elastic001]

TASK [Set environment Elastic] *****************************************************************************************************************
--- before
+++ after: /home/nonstop/.ansible/tmp/ansible-local-221239khw7w2m_/tmpxfcyrgrw/elk.sh.j2
@@ -0,0 +1,5 @@
+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
+#!/usr/bin/env bash
+
+export ES_HOME=/opt/elastic/7.10.1
+export PATH=$PATH:$ES_HOME/bin
\ No newline at end of file

changed: [elastic001]

PLAY [Install Kibana] **************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************
ok: [kibana001]

TASK [Upload tar.gz Kibana from remote URL] ****************************************************************************************************
changed: [kibana001]

TASK [Create directrory for Kibana (/opt/kibana/7.12.0)] ***************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/kibana/7.12.0",
-    "state": "absent"
+    "state": "directory"
 }

changed: [kibana001]

TASK [Extract Kibana in the installation directory] ********************************************************************************************
changed: [kibana001]

TASK [Set environment Kibana] ******************************************************************************************************************
--- before
+++ after: /home/nonstop/.ansible/tmp/ansible-local-221239khw7w2m_/tmpq2uv5zf0/kib.sh.j2
@@ -0,0 +1,5 @@
+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
+#!/usr/bin/env bash
+
+export KIBANA_HOME=/opt/kibana/7.12.0
+export PATH=$PATH:$KIBANA_HOME/bin
\ No newline at end of file

changed: [kibana001]

PLAY RECAP *************************************************************************************************************************************
elastic001                 : ok=11   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
kibana001                  : ok=11   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 


 8. Повторно запустите playbook с флагом --diff и убедитесь, что playbook идемпотентен.

21:12:29 nonstop@umbrella:~/devops-ansible/2$ ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Java] ****************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************
ok: [elastic001]
ok: [kibana001]

TASK [Set facts for Java 8 vars] ***************************************************************************************************************
ok: [kibana001]
ok: [elastic001]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************************************
ok: [elastic001]
ok: [kibana001]

TASK [Ensure installation dir exists] **********************************************************************************************************
ok: [elastic001]
ok: [kibana001]

TASK [Extract java in the installation directory] **********************************************************************************************
skipping: [elastic001]
skipping: [kibana001]

TASK [Export environment variables] ************************************************************************************************************
ok: [elastic001]
ok: [kibana001]

PLAY [Install Elasticsearch] *******************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************
ok: [elastic001]

TASK [Upload tar.gz Elasticsearch from remote URL] *********************************************************************************************
ok: [elastic001]

TASK [Create directrory for Elasticsearch] *****************************************************************************************************
ok: [elastic001]

TASK [Extract Elasticsearch in the installation directory] *************************************************************************************
skipping: [elastic001]

TASK [Set environment Elastic] *****************************************************************************************************************
ok: [elastic001]

PLAY [Install Kibana] **************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************
ok: [kibana001]

TASK [Upload tar.gz Kibana from remote URL] ****************************************************************************************************
ok: [kibana001]

TASK [Create directrory for Kibana (/opt/kibana/7.12.0)] ***************************************************************************************
ok: [kibana001]

TASK [Extract Kibana in the installation directory] ********************************************************************************************
skipping: [kibana001]

TASK [Set environment Kibana] ******************************************************************************************************************
ok: [kibana001]

PLAY RECAP *************************************************************************************************************************************
elastic001                 : ok=9    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
kibana001                  : ok=9    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   


## 9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.



 ## 10. Готовый playbook выложите в свой репозиторий, в ответ предоставьте ссылку на него.

https://github.com/Nonstopus/devops-netology/blob/main/ansible/2/
