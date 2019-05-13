import re

params = {}
with open('voiceparam.txt') as file:
    for line in file:
        if line[0] == '\x1a':
            break
        m = re.match('\[([0-9 ]*)\]', line)
        if m:
            n = int(m.group(1))
            params[n] = []
        else:
            params[n] += list(map(int, line.split()))

lfospeed = []
for n in params:
    lfospeed.append(params[n][4])
print(sorted(lfospeed))
