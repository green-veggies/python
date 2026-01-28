# strings
s1 = 'Hello'
print(s1)
print(type(s1))
print(id(s1))

# multiline strings
a = '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum porta dui sit amet convallis semper. 'Morbi et lectus nulla.' """"""" """ "" " @!@#$%^&*() Sed congue sem neque. Aenean in velit efficitur, consectetur velit quis, varius odio. Nulla vulputate elit non nisi bibendum, vitae sollicitudin felis ultrices. Suspendisse aliquet risus vel ullamcorper suscipit. Ut nec commodo lectus, quis cursus felis.'''
print(a)
print(type(a))

# 
s = 'hello'
print(s[1])

# slice (start,end,steps)
s = "GREEN_VEgGIES"
print(s[1:9])
print("length: ",len(s)) #len(string)
print("reverse: ",s[::-1]) # reverse the string
print("Upper case: ",s.upper())
print("lower case: ",s.lower())
print("Swap case: ",s.swapcase()) # lower to upper and vice versa
print("Title case: ",s.title()) # first letter of each word
print("capitalize case: ",s.capitalize()) # first letter of each sentence

print("Green" + " " + "Veggies") # concatenation

#split
print(s.split())
print(s.split('E'))

#typecasting
print('//////Typecasting///////')
print(int('20'))
print(float("10.3654647"))
print(complex("10.3654647"))
print(type(str(10))) # string as type

#immutable
x1=10.50567
print(x1)
print(id(x1))

x=20.746
print(x)
print(id(x))

y = 10.50567
print(y)
print(id(y))

print(x1 is y) # is operator
