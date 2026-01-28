# tuple revisit

t1 = (10,20,30,40,50, 5)
print(t1)
print(type(t1))

# tuple operations
'''
t2 = 1,2,3,4
t5 = t1

print('t2', t2)
print('t5', t5)

## Concatenation

t6 = t2 + t5
print('t6', t6)

## Repetition
t7 = t6 * 2
print('t7', t7)

print('Length of t7', len(t7))
print(t7.count(1))  # number of occurrences
print(t7.index(1))  # first occurrence

print(sorted(t7))  # sort elements
print(sorted(t7, reverse=True))  # reverse order

print(min(t7))
print(max(t7))
'''

## packing and unpacking
print("////packing and unpacking////")
a=10;b=20;30;d=40; e = "hello"
tup = a,b,30,d,50, e
print('tuple: ', tup)
p,q,r,s,t,u = tup
print(p,q,r,s,t,u)

a, *b = (1,2,3,4,36,4646)
print("a= ", a, " ","b= ", b)