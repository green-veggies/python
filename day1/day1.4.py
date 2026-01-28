#range

'''r = range(10,20,2)
print(r)
print(type(r))
for number in r:
    print(number)'''


#lists
l2 = [1, 2, "Hello", "Python", 5]
print(l2)
print(type(l2))
print(id(l2))

print(l2[0])
print(type(l2[0]))
l2[0] = "value is updated"
print(l2*2)

# Tuples
t = (1,2,"hello world", "python", 5)
print(t)
# print(type(t))
print(t[2])
# t[2] = "hi world" -> not allowed

# dictionary


d1 = {'R': 'Red', 'B': 'Blue'}
print(d1)
print(type(d1))

d1['R'] = "Rome"
d1[12] = 1325346
print(d1)

#set
s1 = {100, 0, 100, 10, 'Hello',0,0,0}
print(s1)
print(len(s1))
