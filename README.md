pentru a putea rula scriptul trebuie sa dam permisiuni de executie: chmod +x log.sh
rulam ./log.sh 5 
cat system-state.log 

Trebuie instalat python3
teme@vm2:~/git-projects/proiect$ python3 --version
Python 3.10.12

teme@vm2:~/git-projects/proiect/scripts$ python3 backup.py
2025-08-05 16:52:31,020 - ERROR - Te rog sa specifici calea catre fisier!!!
teme@vm2:~/git-projects/proiect/scripts$ python3 backup.py system-state.log 
2025-08-05 16:52:35,105 - WARNING - Directorul backup nu exista. Il creez..
2025-08-05 16:52:35,106 - DEBUG - Exista fisierul system-state.log.
2025-08-05 16:52:35,115 - INFO - Rezultatul comenzii md5sum, este [b'c6633985d184cbb43f74768870521e9e', b'system-state.log'].
2025-08-05 16:52:35,115 - INFO - Hash-ul fisierului system-state.log este c6633985d184cbb43f74768870521e9e
c6633985d184cbb43f74768870521e9e
2025-08-05-16-52-35
2025-08-05 16:52:35,116 - INFO - Fisierul cu numele system-state.log.2025-08-05-16-52-35.backup a fost creat
2025-08-05 16:52:40,126 - DEBUG - Exista fisierul system-state.log.
2025-08-05 16:52:40,135 - INFO - Rezultatul comenzii md5sum, este [b'c6633985d184cbb43f74768870521e9e', b'system-state.log'].
2025-08-05 16:52:40,135 - INFO - Hash-ul fisierului system-state.log este c6633985d184cbb43f74768870521e9e
c6633985d184cbb43f74768870521e9e
2025-08-05 16:52:40,135 - INFO - Verificam hash-ul fisierului cu numele: system-state.log.2025-08-05-16-52-35.backup
2025-08-05 16:52:40,141 - INFO - Rezultatul comenzii md5sum, este [b'c6633985d184cbb43f74768870521e9e', b'backup/system-state.log.2025-08-05-16-52-35.backup'].
2025-08-05 16:52:40,142 - INFO - Hash-ul fisierului backup/system-state.log.2025-08-05-16-52-35.backup este c6633985d184cbb43f74768870521e9e
2025-08-05 16:52:40,142 - INFO - Exista deja un backup al fisierului cu numele system-state.log.2025-08-05-16-52-35.backup
2025-08-05 16:52:45,249 - DEBUG - Exista fisierul system-state.log.
2025-08-05 16:52:45,255 - INFO - Rezultatul comenzii md5sum, este [b'c6633985d184cbb43f74768870521e9e', b'system-state.log'].
2025-08-05 16:52:45,255 - INFO - Hash-ul fisierului system-state.log este c6633985d184cbb43f74768870521e9e
c6633985d184cbb43f74768870521e9e
2025-08-05 16:52:45,255 - INFO - Verificam hash-ul fisierului cu numele: system-state.log.2025-08-05-16-52-35.backup
2025-08-05 16:52:45,261 - INFO - Rezultatul comenzii md5sum, este [b'c6633985d184cbb43f74768870521e9e', b'backup/system-state.log.2025-08-05-16-52-35.backup'].
2025-08-05 16:52:45,263 - INFO - Hash-ul fisierului backup/system-state.log.2025-08-05-16-52-35.backup este c6633985d184cbb43f74768870521e9e
2025-08-05 16:52:45,263 - INFO - Exista deja un backup al fisierului cu numele system-state.log.2025-08-05-16-52-35.backup
^CTraceback (most recent call last):
  File "/home/teme/git-projects/proiect/scripts/backup.py", line 64, in <module>
    time.sleep(5)
KeyboardInterrupt

Trebuie sa instalam docker
teme@vm2:~/git-projects/proiect$ docker --version
Docker version 28.3.2, build 578ccf6

Verificam daca este pornit vreun container

teme@vm2:~/git-projects/proiect$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

Am creat 2 Dockerfile, unul pentru scriptul sh si unul pentru cel de python
Construim imaginea cu tag-ul "monitor iamge"
teme@vm2:~/git-projects/proiect/docker$ docker build -t monitor-image -f Dockerfile-monitor .
[+] Building 1.1s (8/9)                                                                                              docker:default
 => [internal] load build definition from Dockerfile-monitor                                                                   0.0s
 => => transferring dockerfile: 160B                                                                                           0.0s
 => [internal] load metadata for docker.io/library/ubuntu:latest                                                               1.0s
 => [internal] load .dockerignore                                                                                              0.0s
 => => transferring context: 2B                                                                                                0.0s
 => CANCELED [1/5] FROM docker.io/library/ubuntu:latest@sha256:a08e551cb33850e4740772b38217fc1796a66da2506d312abe51acda354ff0  0.0s
 => => resolve docker.io/library/ubuntu:latest@sha256:a08e551cb33850e4740772b38217fc1796a66da2506d312abe51acda354ff061         0.0s
 => => sha256:65ae7a6f3544bd2d2b6d19b13bfc64752d776bc92c510f874188bfd404d205a3 2.30kB / 2.30kB                                 0.0s
 => => sha256:a08e551cb33850e4740772b38217fc1796a66da2506d312abe51acda354ff061 6.69kB / 6.69kB                                 0.0s
 => => sha256:4f1db91d9560cf107b5832c0761364ec64f46777aa4ec637cca3008f287c975e 424B / 424B                                     0.0s
 => [internal] load build context                                                                                              0.0s
 => => transferring context: 2B                                                                                                0.0s
 => CACHED [2/5] RUN apt-get update                                                                                            0.0s
 => CACHED [3/5] WORKDIR /src                                                                                                  0.0s
 => ERROR [4/5] COPY scripts/log.sh .                                                                                          0.0s
------
 > [4/5] COPY scripts/log.sh .:
------
Dockerfile-monitor:4
--------------------
   2 |     RUN apt-get update
   3 |     WORKDIR /src
   4 | >>> COPY scripts/log.sh .
   5 |     RUN chmod +x log.sh
   6 |     CMD ["bash", "log.sh"]
--------------------
ERROR: failed to build: failed to solve: failed to compute cache key: failed to calculate checksum of ref b26ef8fb-d9f3-48a9-9247-e891795782b8::r2mehri7pezo67g7cdterqdua: "/scripts/log.sh": not found
teme@vm2:~/git-projects/proiect/docker$ cd ..
teme@vm2:~/git-projects/proiect$ docker build -t monitor-image -f Dockerfile-monitor .
[+] Building 0.1s (1/1) FINISHED                                                                                     docker:default
 => [internal] load build definition from Dockerfile-monitor                                                                   0.0s
 => => transferring dockerfile: 2B                                                                                             0.0s
ERROR: failed to build: failed to solve: failed to read dockerfile: open Dockerfile-monitor: no such file or directory
teme@vm2:~/git-projects/proiect$ docker build -t monitor-image -f docker/Dockerfile-monitor .
[+] Building 8.8s (10/10) FINISHED                                                                                   docker:default
 => [internal] load build definition from Dockerfile-monitor                                                                   0.0s
 => => transferring dockerfile: 160B                                                                                           0.0s
 => [internal] load metadata for docker.io/library/ubuntu:latest                                                               0.5s
 => [internal] load .dockerignore                                                                                              0.0s
 => => transferring context: 2B                                                                                                0.0s
 => [1/5] FROM docker.io/library/ubuntu:latest@sha256:a08e551cb33850e4740772b38217fc1796a66da2506d312abe51acda354ff061         3.7s
 => => resolve docker.io/library/ubuntu:latest@sha256:a08e551cb33850e4740772b38217fc1796a66da2506d312abe51acda354ff061         0.0s
 => => sha256:65ae7a6f3544bd2d2b6d19b13bfc64752d776bc92c510f874188bfd404d205a3 2.30kB / 2.30kB                                 0.0s
 => => sha256:32f112e3802cadcab3543160f4d2aa607b3cc1c62140d57b4f5441384f40e927 29.72MB / 29.72MB                               2.2s
 => => sha256:a08e551cb33850e4740772b38217fc1796a66da2506d312abe51acda354ff061 6.69kB / 6.69kB                                 0.0s
 => => sha256:4f1db91d9560cf107b5832c0761364ec64f46777aa4ec637cca3008f287c975e 424B / 424B                                     0.0s
 => => extracting sha256:32f112e3802cadcab3543160f4d2aa607b3cc1c62140d57b4f5441384f40e927                                      1.4s
 => [internal] load build context                                                                                              0.0s
 => => transferring context: 739B                                                                                              0.0s
 => [2/5] RUN apt-get update                                                                                                   3.7s
 => [3/5] WORKDIR /src                                                                                                         0.1s 
 => [4/5] COPY scripts/log.sh .                                                                                                0.1s 
 => [5/5] RUN chmod +x log.sh                                                                                                  0.3s 
 => exporting to image                                                                                                         0.3s 
 => => exporting layers                                                                                                        0.3s 
 => => writing image sha256:c5b39453beca8c21d01b4129ea1308aea75fe061226440625b9dbe82d28a6b93                                   0.0s 
 => => naming to docker.io/library/monitor-image  

 Deoarece scriptul de shell se afla in alt director decat cel de docker in care am incercat prima data sa rulez comanda docker build, am iesit din director, am rulat comanda in directorul principal si am specifical directorul in care se afla docker file-ul 

 Verificam ca s-a construit imaginea:: 
 teme@vm2:~/git-projects/proiect$ docker images
REPOSITORY      TAG       IMAGE ID       CREATED          SIZE
monitor-image   latest    c5b39453beca   28 seconds ago   130MB
buna            latest    5f6cfed4e499   13 days ago      1.02GB
<none>          <none>    a44a288defe1   13 days ago      1.02GB
alpine          latest    9234e8fb04c4   3 weeks ago      8.31MB
nginx           latest    2cd1d97f893f   3 weeks ago      192MB
hello-world     latest    74cc54e27dc4   6 months ago     10.1kB

Vom proceda la fel si pentru imaginea scriptului de backup

teme@vm2:~/git-projects/proiect$ docker build -t backup-image -f docker/Dockerfile-backup .
[+] Building 1.7s (8/8) FINISHED                                                                                     docker:default
 => [internal] load build definition from Dockerfile-backup                                                                    0.0s
 => => transferring dockerfile: 165B                                                                                           0.0s
 => [internal] load metadata for docker.io/library/python:latest                                                               1.3s
 => [internal] load .dockerignore                                                                                              0.0s
 => => transferring context: 2B                                                                                                0.0s
 => CACHED [1/3] FROM docker.io/library/python:latest@sha256:4ea77121eab13d9e71f2783d7505f5655b25bb7b2c263e8020aae3b555dbc0b2  0.0s
 => => resolve docker.io/library/python:latest@sha256:4ea77121eab13d9e71f2783d7505f5655b25bb7b2c263e8020aae3b555dbc0b2         0.0s
 => [internal] load build context                                                                                              0.0s
 => => transferring context: 2.17kB                                                                                            0.0s
 => [2/3] WORKDIR /src                                                                                                         0.1s
 => [3/3] COPY scripts/backup.py .                                                                                             0.1s
 => exporting to image                                                                                                         0.1s
 => => exporting layers                                                                                                        0.0s
 => => writing image sha256:f284f27a76188e7b249e34ed588469e498544eb1cb7878b45bfcba00d1de38b8                                   0.0s
 => => naming to docker.io/library/backup-image                                                                                0.0s
teme@vm2:~/git-projects/proiect$ docker images
REPOSITORY      TAG       IMAGE ID       CREATED          SIZE
backup-image    latest    f284f27a7618   5 seconds ago    1.02GB
monitor-image   latest    c5b39453beca   13 minutes ago   130MB
buna            latest    5f6cfed4e499   13 days ago      1.02GB
<none>          <none>    a44a288defe1   13 days ago      1.02GB
alpine          latest    9234e8fb04c4   3 weeks ago      8.31MB
nginx           latest    2cd1d97f893f   3 weeks ago      192MB
hello-world     latest    74cc54e27dc4   6 months ago     10.1kB

Rulam imaginile in detache mod si le da un nume pentru a ne fi mai usor de pornit/oprit containerele

teme@vm2:~/git-projects/proiect$ docker run -d --name system-monitor monitor-image
5a29b1b1620cb30963a619b71fc33676c2e673e3702fa9514d1725ecb73244e1
teme@vm2:~/git-projects/proiect$ docker ps
CONTAINER ID   IMAGE           COMMAND         CREATED         STATUS         PORTS     NAMES
5a29b1b1620c   monitor-image   "bash log.sh"   3 seconds ago   Up 3 seconds             system-monitor
teme@vm2:~/git-projects/proiect$ docker run -d --name system-backup backup-image
adb82b06ac6246bc3cacf8d45ea4999001358ccaddfc121505319418f6f90bae
teme@vm2:~/git-projects/proiect$ docker ps
CONTAINER ID   IMAGE           COMMAND         CREATED          STATUS          PORTS     NAMES
5a29b1b1620c   monitor-image   "bash log.sh"   28 seconds ago   Up 28 seconds             system-monitor
teme@vm2:~/git-projects/proiect$ docker ps
CONTAINER ID   IMAGE           COMMAND         CREATED          STATUS          PORTS     NAMES
5a29b1b1620c   monitor-image   "bash log.sh"   36 seconds ago   Up 36 seconds             system-monitor
teme@vm2:~/git-projects/proiect$ docker ps
CONTAINER ID   IMAGE           COMMAND         CREATED          STATUS          PORTS     NAMES
5a29b1b1620c   monitor-image   "bash log.sh"   55 seconds ago   Up 55 seconds             system-monitor
teme@vm2:~/git-projects/proiect$ docker ps
CONTAINER ID   IMAGE           COMMAND         CREATED              STATUS              PORTS     NAMES
5a29b1b1620c   monitor-image   "bash log.sh"   About a minute ago   Up About a minute             system-monitor
teme@vm2:~/git-projects/proiect$ docker logs system-backup
2025-08-06 13:21:54,386 - ERROR - Te rog sa specifici calea catre fisier!!!

Am modificat Dockerfile-backup:
FROM python
WORKDIR /src
COPY scripts/backup.py .
ENV BACKUP_INTERVAL=5
ENV BACKUP_DIR_PATH=backup
CMD ["python", "backup.py", "system-state.log"], in CMD am adaugat si fisierul caruia i se face backup si am rezolvat eroarea
teme@vm2:~/git-projects/proiect$ docker build -t monitor-image -f Dockerfile-monitor .
[+] Building 0.1s (1/1) FINISHED                                                                                                                                                             docker:default
 => [internal] load build definition from Dockerfile-monitor                                                                                                                                           0.0s
 => => transferring dockerfile: 2B                                                                                                                                                                     0.0s
ERROR: failed to build: failed to solve: failed to read dockerfile: open Dockerfile-monitor: no such file or directory
teme@vm2:~/git-projects/proiect$ docker build -t monitor-image -f docker/Dockerfile-monitor .
[+] Building 2.0s (10/10) FINISHED                                                                                                                                                           docker:default
 => [internal] load build definition from Dockerfile-monitor                                                                                                                                           0.0s
 => => transferring dockerfile: 160B                                                                                                                                                                   0.0s
 => [internal] load metadata for docker.io/library/ubuntu:latest                                                                                                                                       1.1s
 => [internal] load .dockerignore                                                                                                                                                                      0.0s
 => => transferring context: 2B                                                                                                                                                                        0.0s
 => [1/5] FROM docker.io/library/ubuntu:latest@sha256:a08e551cb33850e4740772b38217fc1796a66da2506d312abe51acda354ff061                                                                                 0.0s
 => [internal] load build context                                                                                                                                                                      0.0s
 => => transferring context: 745B                                                                                                                                                                      0.0s
 => CACHED [2/5] RUN apt-get update                                                                                                                                                                    0.0s
 => CACHED [3/5] WORKDIR /src                                                                                                                                                                          0.0s
 => [4/5] COPY scripts/log.sh .                                                                                                                                                                        0.1s
 => [5/5] RUN chmod +x log.sh                                                                                                                                                                          0.5s
 => exporting to image                                                                                                                                                                                 0.1s
 => => exporting layers                                                                                                                                                                                0.1s
 => => writing image sha256:63dd09036c091a4a0c3ac0fe85f4bdb4a4bb6eb43cdfc1f3b82869f393b6b42a                                                                                                           0.0s
 => => naming to docker.io/library/monitor-image                                                                                                                                                       0.0s
teme@vm2:~/git-projects/proiect$ docker build -t backup-image -f docker/Dockerfile-backup .
[+] Building 5.6s (8/8) FINISHED                                                                                                                                                             docker:default
 => [internal] load build definition from Dockerfile-backup                                                                                                                                            0.0s
 => => transferring dockerfile: 192B                                                                                                                                                                   0.0s
 => [internal] load metadata for docker.io/library/python:latest                                                                                                                                       1.9s
 => [internal] load .dockerignore                                                                                                                                                                      0.0s
 => => transferring context: 2B                                                                                                                                                                        0.0s
 => [1/3] FROM docker.io/library/python:latest@sha256:68d0775234842868248bfe185eece56e725d3cb195f511a21233d0f564dee501                                                                                 3.2s
 => => resolve docker.io/library/python:latest@sha256:68d0775234842868248bfe185eece56e725d3cb195f511a21233d0f564dee501                                                                                 0.0s
 => => sha256:c2d8038fe0719799a42e436e8e51920f537b2c3518449fcb753d69509057daf6 2.32kB / 2.32kB                                                                                                         0.0s
 => => sha256:3e7f48ebe9d8b258a2c0273be4a8af2fb855a201ff384de4d1534761c7f4e103 6.32kB / 6.32kB                                                                                                         0.0s
 => => sha256:505bcd5de71db2becc8dafff688d0812a3c5df8eca1e85d6158e3957b14e0498 251B / 251B                                                                                                             0.4s
 => => sha256:66d01326c43588e03963922f1698cb99403558cf7e64a79d9da93e6edf9c5899 6.16MB / 6.16MB                                                                                                         1.0s
 => => sha256:fb5f775313f04521fd0f937e04bdb9e2583276f9c2e275447005a2968c57318d 27.40MB / 27.40MB                                                                                                       1.5s
 => => sha256:68d0775234842868248bfe185eece56e725d3cb195f511a21233d0f564dee501 9.72kB / 9.72kB                                                                                                         0.0s
 => => extracting sha256:66d01326c43588e03963922f1698cb99403558cf7e64a79d9da93e6edf9c5899                                                                                                              0.6s
 => => extracting sha256:fb5f775313f04521fd0f937e04bdb9e2583276f9c2e275447005a2968c57318d                                                                                                              1.3s
 => => extracting sha256:505bcd5de71db2becc8dafff688d0812a3c5df8eca1e85d6158e3957b14e0498  
  => [internal] load build context                                                                                                                                                                      0.0s
 => => transferring context: 2.36kB                                                                                                                                                                    0.0s
 => [2/3] WORKDIR /src                                                                                                                                                                                 0.3s
 => [3/3] COPY scripts/backup.py .                                                                                                                                                                     0.1s
 => exporting to image                                                                                                                                                                                 0.1s
 => => exporting layers                                                                                                                                                                                0.0s
 => => writing image sha256:b98a023655011ffd90e9a935908602a335c9c0b4d720dd4a1897347a05d15dcb                                                                                                           0.0s
 => => naming to docker.io/library/backup-image                                                                                                                                                        0.0s
teme@vm2:~/git-projects/proiect$ docker images
REPOSITORY        TAG       IMAGE ID       CREATED          SIZE
backup-image      latest    b98a02365501   3 seconds ago    1.02GB
monitor-image     latest    63dd09036c09   27 seconds ago   130MB
checklog-image    latest    1238af44988a   3 days ago       1GB
buna              latest    5f6cfed4e499   2 weeks ago      1.02GB
jenkins/jenkins   lts       627182afbe2b   2 weeks ago      472MB
alpine            latest    9234e8fb04c4   3 weeks ago      8.31MB
nginx             latest    2cd1d97f893f   3 weeks ago      192MB
hello-world       latest    74cc54e27dc4   6 months ago     10.1kB

Pornim containere carora le dam si un nume pentru a fi mai usor e gestionat

teme@vm2:~/git-projects/proiect$ docker run -d --name system-monitor monitor-image
a5e47f70c7cd4c5bbee6b49b60be8aaafb1fb74c7dec408900367735708354fb
teme@vm2:~/git-projects/proiect$ docker run -d --name system-backup backup-image
d162fa158a5d3e9c51a32a32c2c31e6a46dfd8609ecacc30157ba6675918a95f
teme@vm2:~/git-projects/proiect$ docker ps
CONTAINER ID   IMAGE           COMMAND                  CREATED          STATUS          PORTS     NAMES
d162fa158a5d   backup-image    "python backup.py sy…"   2 seconds ago    Up 2 seconds              system-backup
a5e47f70c7cd   monitor-image   "bash log.sh"            15 seconds ago   Up 14 seconds             system-monitor
teme@vm2:~/git-projects/proiect$ docker logs system-backup
2025-08-10 13:07:23,587 - WARNING - Directorul backup nu exista. Il creez..

Rularea docker compose:

teme@vm2:~/git-projects/proiect$ docker-compose -f docker/docker-compose.yml up -d
system-monitor is up-to-date
Creating system-backup ... done
teme@vm2:~/git-projects/proiect$ docker ps -a 
CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS                           PORTS                                     NAMES
63ed923040a1   backup-image          "python backup.py sy…"   7 seconds ago    Exited (2) 6 seconds ago                                                   system-backup
43cc2ed09e29   monitor-image         "bash log.sh"            11 minutes ago   Up 11 minutes                                                              system-monitor
920d00b3d010   jenkins/jenkins:lts   "/usr/bin/tini -- /u…"   42 hours ago     Exited (143) About an hour ago                                             jenkins
4b14a5c27034   checklog-image        "python analise-logs…"   3 days ago       Exited (1) 3 days ago                                                      exciting_leavitt
9faff64a9215   checklog-image        "python analise-logs…"   3 days ago       Exited (2) 3 days ago                                                      elastic_poitras
6365d97281d5   0673847ec646          "python analise-logs…"   3 days ago       Exited (1) 3 days ago                                                      musing_mendel
82d517f742be   0673847ec646          "python analise-logs…"   3 days ago       Exited (1) 3 days ago                                                      modest_hoover
0bcc7ca1b096   0673847ec646          "python analise-logs…"   3 days ago       Exited (1) 3 days ago                                                      vibrant_chaum
45c213c7ce67   0673847ec646          "python analise-logs…"   3 days ago       Exited (1) 3 days ago                                                      cool_mendel
48eb2d916174   buna:latest           "python script.py di…"   2 weeks ago      Exited (0) 2 weeks ago                                                     epic_brahmagupta
9e6f3089463e   a44a288defe1          "python script.py di…"   2 weeks ago      Exited (2) 2 weeks ago                                                     beautiful_black
cb4e15bb2d76   a44a288defe1          "python script.py di…"   2 weeks ago      Exited (2) 2 weeks ago                                                     funny_cerf
dd9535881a3d   a44a288defe1          "python script.py di…"   2 weeks ago      Exited (2) 2 weeks ago                                                     serene_gates
5933f7fbd0bd   a44a288defe1          "python script.py"       2 weeks ago      Exited (2) 2 weeks ago                                                     goofy_pasteur
827d0d76225b   nginx                 "/docker-entrypoint.…"   2 weeks ago      Exited (255) 6 days ago          0.0.0.0:8082->80/tcp, [::]:8082->80/tcp   frontend
0dbf296a7ede   alpine                "sh"                     2 weeks ago      Exited (255) 6 days ago                                                    backend
6c6ca8f06c1b   hello-world           "/hello"                 2 weeks ago      Exited (0) 2 weeks ago                                                     pensive_euclid
9439dc42afb0   hello-world           "/hello"                 2 weeks ago      Exited (0) 2 weeks ago                                                     upbeat_gould
86a3ae492195   hello-world           "/hello"                 2 weeks ago      Exited (0) 2 weeks ago                                                     busy_hypatia
teme@vm2:~/git-projects/proiect$ docker logs system-backup
python: can't open file '/src/backup.py': [Errno 2] No such file or directory


Am consultat documentatia in incercarea de a rezolva eroarea: 

https://docs.docker.com/reference/compose-file/build/

dupa ce am modificat docker-compose am recreat imaginile si am pornit containerele
teme@vm2:~/git-projects/proiect$ docker-compose -f docker/docker-compose.yml up -d
Creating network "docker_default" with the default driver
Creating docker_sytem-backup_1  ... done
Creating docker_sytem-monitor_1 ... done
teme@vm2:~/git-projects/proiect$ docker ps
CONTAINER ID   IMAGE           COMMAND                  CREATED         STATUS         PORTS     NAMES
536ab870de2f   monitor-image   "bash log.sh"            5 seconds ago   Up 4 seconds             docker_sytem-monitor_1
5b2378b3bca0   backup-image    "python backup.py sy…"   5 seconds ago   Up 4 seconds             docker_sytem-backup_1
teme@vm2:~/git-projects/proiect$ tree
.
├── ansible
│   └── inventory.ini
├── docker
│   ├── docker-compose.yml
│   ├── Dockerfile-backup
│   ├── Dockerfile-monitor
│   └── scripts
├── jenkins
│   └── setup
│       ├── docker-compose.yml
│       └── start-jenkins.sh
├── README.md
├── scripts
│   ├── backup
│   │   ├── log.sh.2025-08-10-15-55-30.backup
│   │   ├── system-state.log.2025-08-05-16-52-35.backup
│   │   ├── system-state.log.2025-08-10-14-13-09.backup
│   │   ├── system-state.log.2025-08-10-14-13-14.backup
│   │   ├── system-state.log.2025-08-10-14-13-19.backup
│   │   ├── system-state.log.2025-08-10-14-13-24.backup
│   │   ├── system-state.log.2025-08-10-14-13-29.backup
│   │   ├── system-state.log.2025-08-10-14-13-34.backup
│   │   ├── system-state.log.2025-08-10-14-13-45.backup
│   │   ├── system-state.log.2025-08-10-14-13-50.backup
│   │   └── system-state.log.2025-08-10-14-13-55.backup
│   ├── backup.py
│   ├── log.sh
│   └── system-state.log
└── terraform

si le-am si oprit pentru ca se genereau f mult fisirele de backup
docker-compose -f docker/docker-compose.yml down

ANSIBLE

Am instalat o noua masina virtuala, cu aceleasi caracteristici ca masina main.
Pasi de configurare:
1. verificam daca pe masina main avem generata o cheie publica cu comanda: ls ~/.ssh/id_rsa.pub
teme@vm2:~/git-projects/proiect$ ls ~/.ssh/id_rsa.pub
/home/teme/.ssh/id_rsa.pub
2. verificam si pe masina remote daca avem generata o cheie publica: ls ~/.ssh/id_rsa.pub
ansible@ansible:~$ ls ~/.ssh/id_rsa.pub
ls: cannot access '/home/ansible/.ssh/id_rsa.pub': No such file or directory
3. ppe masina remote nu este generata nicio cheie publica, generam cheia:
ansible@ansible:~$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/ansible/.ssh/id_rsa): 
Created directory '/home/ansible/.ssh'.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/ansible/.ssh/id_rsa
Your public key has been saved in /home/ansible/.ssh/id_rsa.pub
The key fingerprint is:

Instalam serviciul ssh pe masina remote pentru a putea stabili comunicare ssh intre cele doua masina: 

