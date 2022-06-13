
**Задача 1.**
Скачиваем образ

C:\officedep>docker pull nginx                                                                                                                       Using default tag: latest                                                                                                                            latest: Pulling from library/nginx
42c077c10790: Pull complete
62c70f376f6a: Pull complete
915cc9bd79c2: Pull complete
75a963e94de0: Pull complete
7b1fab684d70: Pull complete                                                                                                                          db24d06d5af4: Pull complete                                                                                                                          Digest: sha256:2bcabc23b45489fb0885d69a06ba1d648aeda973fae7bb981bafbb884165e514                                                                      Status: Downloaded newer image for nginx:latest                                                                                                      docker.io/library/nginx:latest


Собираем
C:\docker\nettology>docker build -t content-nginx .                                                                                                  [+] Building 3.0s (7/7) FINISHED                                                                                                                      => [internal] load build definition from Dockerfile                                                                                            0.4s  => => transferring dockerfile: 81B                                                                                                             0.1s  => [internal] load .dockerignore                                                                                                               0.5s  => => transferring context: 2B                                                                                                                 0.0s  => [internal] load metadata for docker.io/library/nginx:latest                                                                                 0.0s  => [internal] load build context                                                                                                               0.8s  => => transferring context: 167B                                                                                                               0.0s  => [1/2] FROM docker.io/library/nginx                                                                                                          1.5s  => [2/2] COPY index /usr/share/nginx/html                                                                                                      0.3s  => exporting to image                                                                                                                          0.4s  => => exporting layers                                                                                                                         0.3s  => => writing image sha256:ba9835101b4f264e39c706d3b5db8c88b92b24bc7e48215f3bc4a9fb4a33ab20                                                    0.0s  => => naming to docker.io/library/content-nginx                                                                                                0.0s                                                                                                                                                      Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them        


C:\docker\nettology> docker run -d -p 80:80 content-nginx 

C:\docker\nettology>docker tag content-nginx nonstopus/netology 

C:\docker\nettology>docker push nonstopus/netology                                                                                                   Using default tag: latest                                                                                                                            The push refers to repository [docker.io/nonstopus/netology]
70abb7afc772: Pushed
33e3df466e11: Mounted from library/nginx
747b7a567071: Mounted from library/nginx
57d3fc88cb3f: Mounted from library/nginx
53ae81198b64: Mounted from library/nginx                                                                                                             58354abe5f0e: Mounted from library/nginx                                                                                                             ad6562704f37: Mounted from library/nginx                                                                                                             latest: digest: sha256:e817e995103d55b26cfd62a83bc661ec3774c800b02e531663eeb6dd0706a46f size: 1777

https://hub.docker.com/repository/docker/nonstopus/netology




**Задача 2.**
Сценарий:

 - Высоконагруженное монолитное java веб-приложение;

	Для данного случая лучше подойдет выделенный сервер, либо виртуальная машина, т.к. монолит работает в одной JVM, по факту это один процесс на одном сервере
	

 - Nodejs веб-приложение;

	Т.к. это веб приложение, можно разместить его в докере
	
	
    

 - Мобильное приложение c версиями для Android и iOS;

	Рекомендую разместить в виртуальной машине, т.к. при нормальном использовании docker контейнер не имеет gui
    
	

 - Шина данных на базе Apache Kafka;

	Возможно использование, как виртуальных машин, так и докер контейнера, т.к. Apache Kafka легко масштабируется горизонтально, путём добавления новых нод в кластер
	

 - Elasticsearch кластер для реализации логирования продуктивного
   веб-приложения - три ноды elasticsearch, два logstash и две ноды
   kibana;

	Возможно использование в виде Elasticsearсh на виртуальной машине, вопрос отказоустойчивости решать кластером, кибана и логсташ в докер контейнер или так же развернуть на виртуальных машинах.
	
    

 - Мониторинг-стек на базе Prometheus и Grafana;

	Можно развернуть в докере
	
  

 - MongoDB, как основное хранилище данных для java-приложения;

	Возможно развернуть, как на физическом сервере(решив вопрос отказоустойчивости кластером), так и на виртуальной машине и в докере(не храня данные в контейнере)
	
    

 - Gitlab сервер для реализации CI/CD процессов и приватный (закрытый)
   Docker Registry.

	На мой взгляд, оптимально развернуть в виртуальной машине, но примеры в интернете говорят о том, что можно и в докере.
	
	
	**Задача 3.**
	Скачиваем debian и centos
	
	C:\docker\netology2>docker pull centos                                                                                                               Using default tag: latest                                                                                                                            latest: Pulling from library/centos                                                                                                                  a1d0c7532777: Pull complete                                                                                                                          Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177                                                                      Status: Downloaded newer image for centos:latest                                                                                                     docker.io/library/centos:latest                                                                                                                                                                                                                                                                           C:\docker\netology2>docker pull debian                                                                                                               Using default tag: latest                                                                                                                            latest: Pulling from library/debian                                                                                                                  e756f3fdd6a3: Pull complete                                                                                                                          Digest: sha256:3f1d6c17773a45c97bd8f158d665c9709d7b29ed7917ac934086ad96f92e4510                                                                      Status: Downloaded newer image for debian:latest                                                                                                     docker.io/library/debian:latest   
	Запускаем контейнер с centos
	C:\docker\netology2>docker run --rm -it -v //c/docker/netology/netology2/data:/data centos
	Запускаем контейнер с debian
	
	
	Создаем файл с первого контейнера текстовый файл
	[root@06e1c77faa3c /]# cd /data
	[root@06e1c77faa3c /]# vi test.txt
	
	Добавляем еще один файл
	[root@alabama]#touch test2.txt
	
	Листинг из другого контейнера
	root@f8519fee94e7:/data# ls
  
test.txt  test2.txt
	
