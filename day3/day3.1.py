# USE CASE : Monte Carlo Style of simulation of investment growth

# FUNCTION
'''
def get_amount(initial,rate,time):
    amount = initial
    for _ in range (time):
        amount+=amount*rate/100
    return amount
print('₹1000 invested in stocks with return of 8% for 20 years', get_amount(1000,8,20))
print('₹1000 invested in savings with return of 4% for 20 years', get_amount(1000,4,20))
'''

# COLLECTION OF ORGANISING DATA
'''
years = 20
investments = [('stocks',500),('savings',500)]
rates = {'stocks':8,'savings':4}

for item in investments:
    category = item[0]
    amount = item[1]
    rate = rates[category]
    print(category,amount,rate)
'''

# COLLECTION OF ORGANISING DATA - using randomness
from dataclasses import dataclass
import random as r

def get_stock_rate():
    return r.randint(-8,20)

def get_savings_rate():
    return r.randint(2,5)

def get_amt(initial,rate_fn,time):
    amount = initial
    for _ in range (time):
        amount+=amount*rate_fn()/100
    return amount

def run_simulation():
    years = 20
    investments = [('stocks',500),('savings',500)]
    rates = {'stocks':get_stock_rate,'savings':get_savings_rate}
    total = 0
    for item in investments:
        category = item[0]
        amount = item[1]
        rate_fn = rates[category]
        total = total+get_amt(amount,rate_fn,years)
    return total
outputs = []
for run in range(10000):
    outputs.append(run_simulation())
print("max value: ", max(outputs))
print("min value: ", min(outputs))
print("avg value: ", sum(outputs)/len(outputs))

# Write results to file

from datetime import datetime as dt
with open('simulation_output.txt','a') as f:
    f.write(50*'-'+'\n')
    f.write('Execution time: '+str(dt.now())+'\n')
    f.write("max value: "+ str(max(outputs))+'\n')
    f.write("min value: "+ str(min(outputs))+'\n')
    f.write("avg value: "+ str(sum(outputs)/len(outputs))+'\n')

