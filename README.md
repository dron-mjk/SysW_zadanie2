# Zadanie 2 część obowiązkowa
Do realizacji zadania, użyłem pomocniczego repozytorium na docker.io, na które jest wrzucany zbudowany obraz oraz cache. Następnie obraz jest skanowany przez docker scouta i jeżeli nie zostaną wykryte podatności typu critical lub high, będzie on wrzucony na repozytorium ghcr.io, połączone z repozytorium kodu git z kodem źródłowym.


## Potwierdzenie poprawnego wykonania workflowa

![image](https://github.com/user-attachments/assets/e9cc6510-ec0a-4d50-8837-9b95047d2cc6)

## Symulacja sytuacji w której znaleziono podatność
Aby sprawdzić poprawne działanie całego workflow, tymczasowo usunąłem aktualizowanie apk oraz zmieniłem obraz na alpine:3.19, co spowodowało, że w obazie występowały podatności. Tak jak zakładano, podczas sprawdzania obrazu przez docker scouta, zostały one wykryte, a obraz nie został wrzucony na repozytorium ghcr.io
Zmieniona część kodu w pliku Dockerfile:
```
#FROM alpine:latest as stage1
FROM alpine:3.19 as stage1

WORKDIR /var

#RUN apk update && \
#    apk upgrade && \
RUN apk add git python3 py3-pip
```
Potwierdzenie poprawnego działania:
![image](https://github.com/user-attachments/assets/5cbf8a75-19d1-4f05-b047-5a9454205fec)

Stage z docker scoutem zwrócił błąd, przez co 2 następne stage nie zostały wykonane

![image](https://github.com/user-attachments/assets/9eb0e2d6-531e-47cb-b1d3-0c3c2988e243)



# Zadanie 2 część dodatkowa
Aby zrealizować to zadanie utworzyłem drugi workflow, który zamiast docker scouta do sprawdzania obrazów pod kątem podatności cve używa trivy.
