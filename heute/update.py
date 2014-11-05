#!/usr/bin/env python

from datetime import datetime, timedelta
import caldav
from caldav.elements import dav, cdav

import json

url = "http://user:password@server:80/remote.php/caldav/"

client = caldav.DAVClient(url)
principal = caldav.Principal(client)
calendar = caldav.Calendar(client,url)

today = datetime.utcnow().date()
events = calendar.date_search(today, today + timedelta(days=1))

print calendar.get_properties([dav.DisplayName(),])
print('Found %d events' % len(events))

json_events = []
for event in events:
        evt = event.instance.contents['vevent'][0]
        json_events.append( dict(
                summary = evt.contents['summary'][0].value.replace('\\','').encode("utf-8"),
                start = evt.contents['dtstart'][0].value.strftime("%H:%M"),
                ende = evt.contents['dtend'][0].value.strftime("%H:%M") ,) )

file("heute.json", "wb").write(json.dumps(json_events, ensure_ascii=False).encode("utf8"))
print "done"

