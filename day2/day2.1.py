# list revisit

list1  = []
print(list1)
print(type(list1))

list2 = list(range(0,20,2))
print(list2)
print(type(list2))

str1 = 'green veggies'
l = str1.split('e')
print(l)

#appending items in a list

'''
list4 = []
print(list4, len(list4))

list4.append(1)
list4.append(20.5)
list4.append("Hello")
list4.append(True)
print(list4, len(list4))
'''

# list slicing
'''
l2 = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
print(l2)
print(l2[2:7])      # elements from index 2 to 6
print(l2[2:9:2])    # every 2nd element from index 2 to 8
print(l2[2:700])    # slicing beyond length is safe
print(l2[::-1])     # reversed list
print(l2[4:0:-2])   # reverse step slicing
'''

# list concatenation
l1 = [1, 2, 3]
l2 = [4, 5, 6]
l3 = l1 + l2
print('list concatenation: ',l3)

# list of multiples
'''
list1 = []
for x in range(0,121):
    if x % 12 == 0:
        list1.append(x)
print(list1)
'''

# list copy - deep and shallow

l5 = [5, 6, 7]
l6 = l5  # reference
l5.append(100)
print("l5:", l5)
print("l6:", l6)

l7 = l5.copy()  # shallow copy
l5.append(222)
l5.insert(0,105) # insert function (position,value)
# l5.pop() # pop() function to remove last element
l5.sort() # sort function
# l5.clear() # clears the list and makes it empty
# l5.remove(105) # removes let most element if found
print("l5 original:", l5)
print("l6 deep:", l6)
print("l7 shallow:", l7)

# list comprehension
s = [x* x for x in range(1,11)]
print(s)

s1 = [x for x in s if x%2==0]
print(s1)

# words operations using comprehension
words = ['Identifiers', 'Keywords', 'Datatypes', 'Operators']
c = [w[0] for w in words]  # first character of each word
print(c)

str1 = "the quick brown fox jumps over the lazy dog"
words = str1.split()
a = [(w.upper(),len(w),w[0]) for w in words]
print(a)

# elements not present in other list
print("///elements not present in other list///")
list1 = ['a', 'b', 'c', 'd', 'e', 'f']
list2 = ['b','c',"f",'k']
list3 = [e for e in list1 if e not in list2]
list3 = list3+  [e for e in list2 if e not in list1]
print(list3)

