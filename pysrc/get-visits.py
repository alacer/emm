import re
import os
import sys
import csv
import time
import httplib
import datetime
import itertools
import operator

# Based on example from 
# http://www.ibm.com/developerworks/library/wa-apachelogs/

# This regular expression is the heart of the code.
# Python uses Perl regex, so it should be readily portable
# The r'' string form is just a convenience so you don't have to escape backslashes
COMBINED_LOGLINE_PAT = re.compile(
    r'(?P<origin>(\d+\.\d+\.\d+\.\d+|\S+(\.\S+)*(\.\S+))) '
    + r'(?P<identd>-|\w*) (?P<auth>-|\w*) '
    + r'\[(?P<ts>(?P<date>[^\[\]:]+):(?P<time>\d+:\d+:\d+)) (?P<tz>[\-\+]?\d\d\d\d)\] '
    + r'"(?P<method>\w+) (?P<path>[\S]+) (?P<protocol>[^"]*?)" (?P<status>\d+) (?P<bytes>-|\d+)'
    + r'( (?P<referrer>"[^"]*")( (?P<client>"[^"]*")( (?P<cookie>"[^"]*"))?)?)?\s*\Z'
    )

# Since the log file we are using is from 1995, there are some entries for which
# no HTTP protocol is listed. 
COMBINED_LOGLINE_PAT_BU = re.compile(
    r'(?P<origin>(\d+\.\d+\.\d+\.\d+|\S+(\.\S+)*(\.\S+))) '
    + r'(?P<identd>-|\w*) (?P<auth>-|\w*) '
    + r'\[(?P<ts>(?P<date>[^\[\]:]+):(?P<time>\d+:\d+:\d+)) (?P<tz>[\-\+]?\d\d\d\d)\] '
    + r'"(?P<method>\w+) (?P<path>[\S]+)" (?P<status>\d+) (?P<bytes>-|\d+)'
    + r'( (?P<referrer>"[^"]*")( (?P<client>"[^"]*")( (?P<cookie>"[^"]*"))?)?)?\s*\Z'
    )

BOTS = []


def its_been_too_long(timestamp1, timestamp2):
    """
    Returns true if the difference between timestamp1 and timestamp2 is 
    greater than 15 minutes.
    """
    fmt = '%Y-%m-%dT%H:%M:%S+00:00'
    dt1 = datetime.datetime.strptime(timestamp1, fmt)
    dt2 = datetime.datetime.strptime(timestamp2, fmt)
    delta = abs((dt1 - dt2).seconds)
    return (delta > 15*60)


# Apache's date/time format is very messy, so dealing with it is messy
# This class provides support for managing timezones in the Apache time field
# Reuses some code from: http://seehuhn.de/blog/52
class timezone(datetime.tzinfo):
    def __init__(self, name="+0000"):
        self.name = name
        seconds = int(name[:-2])*3600+int(name[-2:])*60
        self.offset = datetime.timedelta(seconds=seconds)

    def utcoffset(self, dt):
        return self.offset

    def dst(self, dt):
        return self.timedelta(0)

    def tzname(self, dt):
        return self.name


def parse_apache_date(date_str, tz_str):
    '''
    Parse the timestamp from the Apache log file, and return a datetime object
    '''
    tt = time.strptime(date_str, "%d/%b/%Y:%H:%M:%S")
    tt = tt[:6] + (0, timezone(tz_str))
    return datetime.datetime(*tt)


keep = re.compile(r"\S+\.(css|CSS|jpg|JPG|png|PNG|js|JS|gif|GIF|ico|ICO)$")
def is_keeper(match_info):
    """
    Returns true if the status is 200 and the requested item is not for css, 
    jpg, png, or js files.
    """
    if match_info.group('status').find('200') == -1:
        return False
    match = keep.match(match_info.group('path'))
    if match:
        return False
    return True


def is_bot(match_info):
    '''
    Return True if the matched line looks like a robot
    '''
    if match_info.group('client') is None:
        return False
    if match_info.group('client') in BOTS:
        return True
    return False


def usage():
    sys.sterr.write("Usage: less log-file | python get-visits.py bot-file.\n")
    sys.exit(1)


if len(sys.argv) < 2:
    usage()

if not os.path.isfile(sys.argv[1]):
    usage()

with open(sys.argv[1], 'r') as bot_file:
    for line in bot_file:
        BOTS.append(line)

entries = []
count = 0

for count, line in enumerate(itertools.islice(sys.stdin, 0, None)):
    used_back_up_re = False
    match_info = COMBINED_LOGLINE_PAT.match(line)
    if not match_info:
        match_info = COMBINED_LOGLINE_PAT_BU.match(line)
        used_back_up_re = True
    if not match_info:
        sys.stderr.write("Unable to parse log line {0}\n".format(count))
        sys.stderr.write(line)
        continue
    
    if not is_keeper(match_info):
        continue
    if is_bot(match_info):
        continue
    
    entry = {}
    timestamp = parse_apache_date(match_info.group('ts'), 
        match_info.group('tz'))
    timestamp_str = timestamp.isoformat()
    entry['id'] = (match_info.group('origin') + ':' + timestamp_str + 
        ':' + str(count))
    entry['label'] = (entry['id'])
    entry['origin'] = (match_info.group('origin'))
    entry['timestamp'] = (timestamp_str)
    entry['path'] = (match_info.group('path'))
    entry['method'] = (match_info.group('method'))
    if used_back_up_re:
        entry['protocol'] = ('Not Specified')  
    else: 
        entry['protocol'] = (match_info.group('protocol'))
    entry['status'] = (match_info.group('status'))
    entry['status'] += (' ' + httplib.responses[int(entry['status'])])
    if match_info.group('bytes') != '-':
        entry['bytes'] = (match_info.group('bytes'))
    if match_info.group('referrer') != '"-"':
        entry['referrer'] = (match_info.group('referrer'))
    entry['client'] = (match_info.group('client'))
    entries.append(entry)

# order the entries into a sequence of visits
entries.sort(key=lambda x: (x['origin'], x['timestamp']))

OFF_SITE = 1
pages = {}
visits = [OFF_SITE, 2]
pages['Elvis has left the building'] = OFF_SITE
pages[entries[0]['path']] = 2
new_node = 3

for i in range(1, len(entries)):
    if not entries[i]['path'] in pages:
        pages[entries[i]['path']] = new_node
        new_node += 1
    # if previous entry has a different origin or previous entry is older than
    # 15 minutes, then start a new visit (i.e. insert a zero)
    curr_entry = entries[i]
    prev_entry = entries[i-1]
    curr_node = pages[curr_entry['path']]

    if curr_entry['origin'] != prev_entry['origin']:
        visits.append(OFF_SITE)
    elif its_been_too_long(curr_entry['timestamp'], prev_entry['timestamp']):
        visits.append(OFF_SITE)
    visits.append(curr_node)
visits.append(OFF_SITE)

# write visits to visits.csv
with open('visits-ibm.csv', 'w') as out_file:
    for visit in visits:
        out_file.write("{0}".format(visit))
        out_file.write('\n')

sorted_pages = sorted(pages.iteritems(), key=operator.itemgetter(1))
# write sorted pages to pages.csv
with open('pages-ibm.csv', 'w') as out_file:
    writer = csv.writer(out_file)
    for itm in sorted_pages:
        writer.writerow(itm)

