# reverse a string

## using slicing
str1 = "Python"
output = str1[::-1]
print(output)


## using reversed iterator and join
str1 = 'Green veggies'
itr = reversed(str1)
print("type of itr: ", type(itr))
output = "".join(itr)
print(output)

## using while loop
str1 = 'Green veggies'
output=""
i = len(str1)-1
while i>=0:
    output+=str1[i]
    i -=1
print("while loop: ",output)

## rReversal in list
s = "lambda"
print(list(reversed(s)))

# Join into string
print("".join(reversed(s)))

# Loop through
for ch in reversed(s):
    print(ch, end="")