import logging
import os 
import sys
import subprocess
from datetime import datetime
import shutil
import time

# Configuram logging-ul
logging.basicConfig(level=logging.DEBUG, format="%(asctime)s - %(levelname)s - %(message)s")

#citim variabilele de mediu, numele directorului si intervalul de backup
backup_dir_path = os.getenv("BACKUP_DIR_PATH", "backup")
backup_interval = int(os.getenv("BACKUP_INTERVAL", 5))

#Din linia de comanda citim calea catre fisier, trebuie specificata de catre utilizator
if len(sys.argv) <2:
    logging.error("Te rog sa specifici calea catre fisier!!!")
    sys.exit(1)
file_path = sys.argv[1]

#daca nu exista directorul, trebuie creat
if not os.path.isdir(backup_dir_path):
    logging.warning(f"Directorul {backup_dir_path} nu exista. Il creez..")
    os.makedirs(backup_dir_path, exist_ok=True)

#functie care calculeaza hash-ul fisierului
def calculate_hash(file_path):
    md5sum = subprocess.run(["md5sum", file_path], capture_output=True)
    logging.info(f"Rezultatul comenzii md5sum, este {md5sum.stdout.split()}.")
    hash = md5sum.stdout.split()[0].decode()
    logging.info(f"Hash-ul fisierului {file_path} este {hash}")
    return hash
#extrgem numele fisierului dintr-o cale completa
def read_file_name(file_path):
    last_slash = file_path.rfind("/")
    file_name = file_path[last_slash + 1:]
    return file_name

#verificam daca fisierul exista, daca exista, comparam hash-ul cu cel al fisierelor salvate
#daca nu exista un backup identic, trebuie creat
def backup(file_path):
    if os.path.isfile(file_path):
        logging.debug(f"Exista fisierul {file_path}.")
        hash = calculate_hash(file_path)
        print(hash)
        for file_name in os.listdir(backup_dir_path):
            logging.info(f"Verificam hash-ul fisierului cu numele: {file_name}")
            hash_backup_file = calculate_hash(backup_dir_path + "/" + file_name)

            if hash == hash_backup_file:
                logging.info(f"Exista deja un backup al fisierului cu numele {file_name}")
                return

        now = datetime.now()
        time_sufix = now.strftime("%Y-%m-%d-%H-%M-%S")
        print(time_sufix)
        backup_file_name = read_file_name(file_path) + "." + time_sufix + ".backup"
        backup_file_path = backup_dir_path + "/" + backup_file_name
        shutil.copy(file_path, backup_file_path)
        logging.info(f"Fisierul cu numele {backup_file_name} a fost creat")

#se executa la fiecare interval definit pentru a monitoriza modificarile
while True:
    backup(file_path)
    time.sleep(backup_interval)