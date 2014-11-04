#!/usr/bin/python
import sys
import json
import urllib
import pprint
import time

while True:
	vrn = json.loads(urllib.urlopen("http://www.wsw-mobil.de/app-panel.php?p=Wuppertal&s=Schleswiger%20Strasse&l=WSW_Limit").read())
	
	abfahrten = [dict(
	    uhrzeit = f["time"].partition("+")[0],
	    linie = f["number"],
	    ziel = f["direction"],
	    verspaetung = f["time"].partition("+")[2] or "0",
	) for f in vrn["departures"]] # 4 tds pro tr
	
	file("fahrplan.json", "wb").write(json.dumps(abfahrten, ensure_ascii=False).encode("utf8"))
	time.sleep(60)
