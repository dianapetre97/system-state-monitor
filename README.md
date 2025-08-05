pentru a putea rula scriptul trebuie sa dam permisiuni de executie: chmod +x log.sh
rulam ./log.sh 5 
cat system-state.log 
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
