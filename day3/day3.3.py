# Decorator is a function that can take a function as arguments and extend its functionality without modifying the base function


def sample_decorator(func):
    def wrapper():
        print('Before calling')
        func()
        print('After calling')
    return wrapper

@sample_decorator
def say_hello():
    print("Hello, World")
say_hello()

# Divide by zero doesn't give an error with decorator
def smart_div(func):
    def inner(a, b):
        print("We are dividing", a, "by", b)
        if b == 0:
            print("Invalid operation: division by zero is undefined")
            return
        else:
            return func(a, b)
    return inner

@smart_div
def div(a,b):
    return a/b

print(div(10,5))
print(div(10,0))

## Decorator with *args and **kwargs
def smart_decorator(func):
    def wrapper(*args, **kwargs):
        print("Function arguments:", args, kwargs)
        result = func(*args, **kwargs)
        print("Function executed successfully.")
        return result
    return wrapper

@smart_decorator
def greet_person(name, age):
    print(f"Hello {name}, you are {age} years old.")

greet_person("Emma", 28)

## multiple decorators
def bold_decorator(func):
    def wrapper():
        return f"Bold {func()}"
    return wrapper

def italic_decorator(func):
    def wrapper():
        return f"Italic {func()}"
    return wrapper

@bold_decorator
@italic_decorator
def formatted_text():
    return "Decorators are powerful!"

print(formatted_text())