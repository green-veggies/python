# GENERATOR -> A function which generates a sequence of values, uses yield keyword to return values

list_comp = [x*x for x in range(1,100)]
# print(list_comp)
print(type(list_comp))

gen_expr = (x*x for x in range(1,10))
# print(gen_expr)

print(type(gen_expr))
print(next(gen_expr))
print(next(gen_expr))
print(next(gen_expr))
print(next(gen_expr))
print(next(gen_expr))


def generator_demo():
    for i in range(1, 5):
        print("Generating:", i)
        yield i

gen = generator_demo()
print(next(gen))
print(next(gen))
print(next(gen))
print(next(gen))




## memory efficiency of generator
import sys

list_comp = [x * x for x in range(1000)]
gen_expr = (x * x for x in range(1000))

print("List size:", sys.getsizeof(list_comp))
print("Generator size:", sys.getsizeof(gen_expr))