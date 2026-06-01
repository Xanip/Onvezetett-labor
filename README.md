# Onvezetett-labor
Business Intelligence projekt, amely devizaárfolyam- és pénzügyi adatokat gyűjt külső API-kból,
SSIS segítségével ETL folyamatokat hajt végre, adattárházat épít SQL Serverben,
majd Power BI riportokban jeleníti meg az eredményeket.

## Felhasznált technológiák

- MsSQL
- SSIS (SQL Server Integration Services)
- C#
- Python
- Power BI
- Lokális LLM, Ollama

## Dokumentáció
Mind az szöveges dokumentáció, mind az előadás diák megtalálhatóak a `Documentation` mappában. 

## SSIS
Jelenleg egy lokális adatbázissal működik aminek a felépítési kódjait megtalálhatod az MSSQL mappában.
A futtatáshoz elengedhetetlen az SSIS projektben kicserélni az adatbázis kapcsolatot a saját lokális adatbázisodra.

## Python script
Jelenleg a lokális adatbázissal dolgozik, tehát itt is át kell írni a kapcsolatot futtatás elött. 

A futtatás előtt:

- Telepített Python szükséges
- Telepített Ollama szükséges
- Futnia kell a kiválasztott LLM modellnek
- A scriptben be kell állítani az adatbázis kapcsolatot

### Virtuális környezet létrehozása:
```bash
python -m venv venv
```
### Aktiválás:
```bash
venv\Scripts\activate
```
### Szükséges Python csomagok telepítése:
```bash
pip install pyodbc ollama
```
## Power BI
[A projekt ezen a linken keresztül elérhető, GitHub-ra nem volt ajánlott feltölteni.](https://drive.google.com/drive/folders/1pe7j8BHMNa-w4gTpjp5GziDpMakDlPoD?usp=sharing)