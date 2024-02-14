import numpy as np

import matplotlib.pyplot as plt


b = np.array([0, 9, -4])

a = np.array([[3, 2, -2], [2, -1, 3], [1, 4, 2]])

sol = np.linalg.solve(a, b)

print(sol)
