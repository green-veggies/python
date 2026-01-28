#operators

#arithmatic
'''a = 10
b = 2
print('a+b', a+b)
print('a-b', a-b)
print('a*b', a*b)
print('a/b', a/b)
print('a//b', a//b)
print('a%b', a%b)
print('a**b', a**b)'''

#bitwise
'''
print()  # AND
print(1 & 1)
print(1 & 0)
print(0 & 1)
print(0 & 0)

print()  # OR
print(1 | 1)
print(1 | 0)
print(0 | 1)
print(0 | 0)

print()  # XOR
print(1 ^ 1)
print(1 ^ 0)
print(0 ^ 1)
print(0 ^ 0)
'''

#relational
'''a = 10
b = 20
print('a>b', a>b)
print('a>=b', a>=b)
print('a<b', a<b)
print('a<=b', a<=b)

#membership 
l = [1,2,"hello","world"]
if "hello" in l:
    print('found')
else:
    print('not found')

# modules - math module
import math as mathematics
print(mathematics.sqrt(16))
print(mathematics.pi)
print(mathematics.lcm(30,5))
'''

#input and output

'''a = int(input("Enter num 1: "))
b = int(input("Enter num 2: "))
c = int(input("Enter num 3: "))
min_value = a if a<b and a<c else b if b<a and b<c else c
print(min_value)'''


## for loops + if statements
'''print('starting....')
print(range(10))

for i in range(10):
    print(i)

for i in range(10): print(i)

list1 = [1, 2, 3, 4, 5]
for e in list1:
    print(e)

str1 = "Python"
for c in str1:
    print(c, end=" ")

for x in range(21):
    if (x % 2 != 0):
        print(x)

list2 = [10, 20, 30, 40, 50]
sum = 0
for e in list2:
    sum += e
print("Sum of all elements in the list is:", sum)

for i in range(4):
    for j in range(5):
        print("i =", i, " j=", j)'''


# while loops
'''counter = 0
while counter < 5:
    print("Within the while loop and the iteration is", counter)
    counter += 1
print("End of while loop")

name = ""
while name != 'root':
    name = input('Enter the username:')
print("Thank you")'''

#star printing
'''
n = int(input("Enter number of rows: "))
for i in range (1,n+1):
    print("* "*i)
'''


#break
for i in range(10):
    print(i)
    if i == 6:
        print("Breaking the loop at 6")
        break

# continue
for i in range(10):
    if i % 2 == 0:
        continue
    print(i)

# pass
def func():
    pass
a = 10
print(a,func())


#   User has 1000, calculate the amount after 5 years if rate of interest is 10%
amount = 1000; rate = 10; years=5

for _ in range(years):
    amount+=amount*rate/100
print(amount)