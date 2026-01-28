# Logging and Exception Handling

## Every exception in Python is an object. For every exception type, the corresponding classes are available
'''
print("Hello, World")
try:
    print(10/0)
except ZeroDivisionError:
    print("Divide by zero is not possible. Continuing program execution.")
print("Hello, Again")
'''

## multiple try-except
'''
print("Division Operation")
try:
    num1 = int(input("Enter numerator: "))
    num2 = int(input("Enter denominator: "))
    print("The quotient is", num1 // num2)
except ZeroDivisionError:
    print("Cannot divide by zero!")
except ValueError:
    print("Please enter valid integer values only.")
except:
    print("Unexpected error occurred.")
else:
    print("This is else block")
finally:
    print("Cleanup code inside the finally block.")
print("Program Completed.")
'''

## Logging

import logging
import sys
# from logging.handlers import RotatingFileHandler

FORMATTER = logging.Formatter(
    "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
)


def get_console_handler():
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setFormatter(FORMATTER)
    return console_handler

def get_logger(logger_name):
    logger = logging.getLogger(logger_name)
    logger.setLevel(logging.DEBUG)
    logger.addHandler(get_console_handler())
    logger.propagate = False
    return logger
log = get_logger("loggy")

log.debug("This is a debug message")
log.info("This is an info message")
log.warning("This is a warning message")
log.error("This is an error message")
log.critical("This is a critical message")

def main():
    try:
        result = 10 / 0
        print(result)
    except Exception as e:
        log.error(e)

main()
