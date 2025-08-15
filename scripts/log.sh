#!/bin/bash
LOG_FILE="system-state.log" #setam fisierul de output in care se vor scrie logurile sa fie system-state.log
PERIOADA=${PERIOADA:-5} #setat in cazul in care din var de mediu nu se primeste nicio valoare, intervalul defualt e de 5s

while true; do
	{
		#printam data la care se scriu date despre starea sistemului
		echo "Starea Sistemului la data: $(date)"
		echo "--- Utilizare CPU --- "
		#printam informatii despre CPU
		ps aux | awk '{print $3}' | head -5
		echo "--- Utilizare Memorie --- "
		#printam informatii despre memorie
		ps aux | awk '{print $4}' | head -5
		echo "--- Numarul de procese active --- "
		#printam nr de procese active
		nr_procese=$(ps -e | wc -l)
		echo " Numarul total de procese active este: $nr_procese"
		echo "--- Utilizare disk --- "
		#printam informatii despre disk
		df -h
	} | tee "$LOG_FILE"
	sleep "$PERIOADA"
done