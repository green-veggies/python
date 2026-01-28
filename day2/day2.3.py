# dictionary revisit

d1 = {}
d1["key1"] = "value1"
d1["key2"] = "value2"
d2 = d1.copy()

print(d1)
d1.clear()
print(d1)
print(d2)


for k, v in d2.items():
    print(k, "-", v)


# revisit sets

set1 = {}
print(type(set1)) # will create a dictionary, not a set
set2 = set() # create using this
set2 = set(range(1,21))
print(set2)
set2.add(10)
print(set2)

l1 = ['a', 'b']
l2 = ['x', 'y']
set2.update(l1, l2)
print(set2)
set3=set2.copy()
set2.clear()
print(set2)
print(set3)