import sys

# function declaration

def func1():
    print("hello world")
    print("hello world")
    print("hello world")

print("version : " + sys.version)
func1()

#class and object
class Class1:
    def func2(self):
        print("this is class, function 2")

obj1 = Class1()
obj1.func2()

import keyword
print(keyword.kwlist)
