import random as r
from datetime import datetime as dt

# fixed interest rates
def get_standard_rates():
    return 5

def get_premium_rates():
    return 8

def get_amount(initial, rate_fn, time):
    amount = initial
    for _ in range(time):
        amount+=amount*rate_fn()/100
    return amount

def run_simulation():
    years = 15
    customers = 5000

    policies = [
        ('standard',10000),
        ('premium',20000)
    ]

    rates = {
        "standard": get_standard_rates,
        "premium": get_premium_rates,
    }

    total = 0

    for _ in range(customers):
        policy = r.choice(policies)
        category = policy[0]
        amount = policy[1]

        rate_fn = rates[category]
        total = total + get_amount(amount, rate_fn, years)
    return total

outputs = []
for _ in range(10):
    outputs.append(run_simulation())

print("Maximum output value: ",max(outputs))
print("Minimum output value: ",min(outputs))
print("Average output value: ",sum(outputs)/len(outputs))

## Appending values in file
with open('insurance_premium_report.txt','a') as f:
    f.write(50*'-'+'\n')
    f.write('Execution time: '+str(dt.now())+'\n')
    f.write("max value: "+ str(max(outputs))+'\n')
    f.write("min value: "+ str(min(outputs))+'\n')
    f.write("avg value: "+ str(sum(outputs)/len(outputs))+'\n')

