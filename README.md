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
