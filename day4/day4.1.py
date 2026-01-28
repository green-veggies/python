with open("sample_data.csv",'r') as f:
  orders_str = f.readlines()
  for line in orders_str:
    print(line.split())
  print(type(orders_str))