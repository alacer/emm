import re
import sys
import time
import datetime
import itertools


# Based on examples from http://www.ibm.com/developerworks/library/wa-apachelogs/

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

# Look for requests to robots.txt
bot_pattern = re.compile(r'robots.txt')


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


bots = {}
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
    
    bot_match = bot_pattern.search(match_info.group('path'))
    if bot_match:
        bots[match_info.group('origin')] = 1

with open('bots-ibm.csv', 'w') as out_file:
    for bot in bots.keys():
        out_file.write(bot)
        out_file.write('\n')
