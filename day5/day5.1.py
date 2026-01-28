import math
import time
from multiprocessing import Pool

if __name__ == "__main__":
  start = time.perf_counter()
  with Pool(10) as p:
    results2 = p.map(math.factorial, range(25000))
  end = time.perf_counter()

  print(end-start)
