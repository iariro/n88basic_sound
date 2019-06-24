
with open('fmedit.bas',encoding='utf-8') as file:
    n = 1000
    for line in file:
        print('%03d %s' % (n, line.strip()))
        n += 10
