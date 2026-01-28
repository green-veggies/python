import copy
# dictionary nesting
'''
market = {}
print(market)
print(type(market))

market['store1'] = {}
market['store2'] = {}
print(market)

market['store1']['Name'] = 'Online store'
market['store2']['Name'] = 'Offline store'
print(market)

market['store1']['items'] = [
    {'name':'laptop','price':'50000'},
    {'name':'mobile','price':'25000'},
]
market['store2']['items'] = [
    {'name':'headset','price':'5000'},
    {'name':'earphone','price':'1000'},
]

#json prettier
import json
print(json.dumps(market, indent=4))

# print(market['store1']['Name'])
for item in market['store1']['items']:
    print("items in store1: ",item)
    if item['name']=="laptop":
        print("price of laptop: ",item['price'])
'''
    
# shallow and deep copy in NESTED list
# only outer level is shallow copy, the inner lists are still references

l1 = [1,2,3]
l2 = l1.copy()
print('before change')
print(l1)
print(l2)

l1.append(4)
print('After l1 append SHALLOW COPY')
print(l1)
print(l2)

l1 = [1,2,[3,4]]
l2=copy.deepcopy(l1)
print('before change')
print(l1)
print(l2)
l1[2].append(99)
print('After l1 append DEEP COPY')
print(l1)
print(l2)
