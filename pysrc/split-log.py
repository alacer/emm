# This script will split a web server log into two files. The two files
# are named train-log.txt and test-log.txt. The user must specify a cut-off
# day (integer day of the month). All entries before the specified date will 
# constitute the training set and the remaining entries will be the test set.

import re
import sys
import datetime
import itertools


# Based on examples from http://www.ibm.com/developerworks/library/wa-apachelogs/

# This regular expression is the heart of the code.
# Python uses Perl regex, so it should be readily portable
# The r'' string form is just a convenience so you don't have to escape backslashes
date_pattern = re.compile(r'\d+/\w+/\d+:\d+:\d+:\d+')


def write_list_to_file(l, fname):
    with open(fname, 'w') as out_file:
        for line in l:
            out_file.write(line)


def past_date_cutoff(dt_str, cut_off_day):
    fmt = '%d/%b/%Y:%H:%M:%S'
    dt = datetime.datetime.strptime(dt_str, fmt)
    if dt > cut_off_day:
        return True
    else:
        return False

try:
    cut_off_date = datetime.datetime.strptime(sys.argv[1], r'%d/%b/%Y:%H:%M:%S')
except Exception, e:
    sys.stderr.write("Usage: less log-file.txt | python split-log.py 02/Sep/2001:00:30:00\n")
    sys.exit(1)

train = []
test = []
count = 0

for count, line in enumerate(itertools.islice(sys.stdin, 0, None)):
    used_back_up_re = False
    match_info = date_pattern.search(line)
    if not match_info:
        sys.stderr.write("Unable to parse log line {0}\n".format(count))
        sys.stderr.write(line)
        continue
    if past_date_cutoff(match_info.group(0), cut_off_date):
        test.append(line)
    else:
        train.append(line)
    
write_list_to_file(train, 'train-log.txt')
write_list_to_file(test, 'test-log.txt')