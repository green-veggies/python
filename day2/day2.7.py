# Modules and Package

import module1 as m

print(m.x)
m.add(5,6)
print(dir(m))

# File Handling

f = open('testfile.txt','w')
print('File Name:', f.name)
print('File Mode:', f.mode)
print('Is the file readable:', f.readable())
print('Is the file writable:', f.writable())
for i in range(15):
    f.write('This is sample text file'+ str(i+1)+'\n')
print('Is the file closed:', f.closed)
f.close()
print('Is the file closed:', f.closed)

f1 = open('testfile.txt','r')
lines = f1.readlines()
for line in lines:
    print(line.strip())

f1.close()