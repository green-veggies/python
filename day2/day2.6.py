# Functions - grp of statements with a name
# A group of func saved to a file are modules
# A group of modules is a library
'''
def f1():
    print("Python as a functional programming language")
    print("Python as a functional programming language")
    print("Python as a functional programming language")
    print("Python as a functional programming language")
    print("Python as a functional programming language")
f1()
'''

# Function call
'''
def greet(name):
    print("Hello",name)
greet("Aditya")

# return statements
def add(num1, num2):
    return num1 + num2

result = add(3, 5)
print(result)
print(add(7, 9))
'''

# return multiple values
'''
def calc(num1, num2):
    sum_val = num1 + num2
    diff = num1 - num2
    prod = num1 * num2
    div = num1 / num2
    return sum_val, diff, prod, div

# Unpacking tuple
print("unpacking tuples////")
a,b,c,d = calc(10,5)
print(a)
print(b)
print(c)
print(d)
print(calc(10, 2))
'''

## factorial of a number
'''
def fact(n):
    prod = 1
    i = n
    while i > 0:
        prod = prod*i
        i-=1
    return prod

num = int(input("enter the number: "))
print(fact(num))
'''
# keyword arguments

from tkinter import N
from unittest import result


def greet(name, msg):
    print("Hello!", name, msg)

# Positional arguments
greet('Ravi', 'Good Morning')
greet('Good Morning', 'Ravi')

# Keyword arguments
greet(msg='Good Morning', name='Ravi')

# Combination of positional and keyword
greet('Ravi', msg='Good Morning')

# default arguments
def greet(name="user"):
    print('hello', name)
greet()
greet("Abc")

## variable length of arguments
def sum(*n):
    total = 0
    for e in n:
        total+=e
    print("The Sum is", total)
sum()
sum(10,20)
sum(10,20,30,40,50)

# local and global
a="Aditya"
def func1():
    global ab 
    ab = 10
    print(ab,a)
def func2():
    print(a,ab)
func1()
func2()

# factorial using recursion
'''
def fact(num):
    result = 1
    if num == 0:
        result = 1
    else:
        result = num *fact(num-1)
    return result


num = int(input('Enter a number: '))
print(fact(num))
'''

# lambda function

# def sq_num(n):
#     print n*n
sqr = lambda n: n*n
print(sqr(6))

## HIGHER ORDER FUNCTIONS -> takes other functions as arguments and can 
# be lambda functions

def isEven(x):
    if x % 2 == 0:
        return True
    else:
        return False

l1 = [1, 2, 4, 5, 6, 21, 24, 25]
l2 = list(filter(isEven, l1))
print(l2)

# using lambda expression
l3 = [11, 21, 42, 52, 61, 21, 24, 257]
l4 = list(filter(lambda x: x % 2 == 0, l3))
print(l4)


# MAP
def doub(x):
    return x*2
list1 = [1,2,3,4,5,6,7,8]
l2 = list(map(doub,list1))
print("doubling ",l2)

## using lambda
l3 = list(map(lambda x:x*2,list1))
print("using lambda", l3)

# reduce
from functools import reduce

l7 = [1, 2, 3, 4, 5]
res = reduce(lambda x, y: x + y, l7)
print(res)

# alias

def greet():
    print("greeted")
wish=greet
wish()
