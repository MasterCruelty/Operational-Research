import requests
import time
url = input("Inserisci il sito di ricerca operativa: ")
print("Inizio a controllare...")
check = False
while check == False:
     resp = requests.get(url)
     if "matricola" in resp.text or "Matricola" in resp.text:
             print("Esiti pubblicati")
             check = True
     else:
             print("Ancora niente esiti")
             time.sleep(60)