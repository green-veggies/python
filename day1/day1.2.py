#datatype and variables
a = 10
print(a)

cash = 500
print(cash)

# Invalid identifier: contains special character
# ca$h = 500  # SyntaxError

total = 1000
print(total)

TOTAL = 5000
print(total)  # 1000
print(TOTAL)  # 5000

total123 = 4000
print(total123)

# print, type and id
a = 100
print(a)
print(type(a))
print(id(a))

# when given binary, input is printed in default int format
a = 0b111
print(a)
print(type(a))
print(id(a))

a = 0B111
print(a)
print(type(a))
print(id(a))

# float 
a = 0.99
print(a)
print(type(a))

# boolean
a = True
print(a)
print(type(a))

# boolean True is 1 and boolean False is 0
print(True+True) #1+1=2

#bytes 
b = [10,20,30,40,50]
print(b)
print(type(b))
by = bytes(b)
print(by)
print(type(by))



