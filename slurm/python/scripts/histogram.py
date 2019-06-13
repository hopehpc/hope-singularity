# Create an example histogram using matplotlib
# Modified from https://www.tutorialkart.com/matplotlib-tutorial/

from matplotlib import pyplot as plt
from matplotlib import style
import random

x = random.sample(range(1, 5000), 1000)
num_bins = 100
n, bins, patches = plt.hist(x, num_bins, facecolor="blue", alpha=0.5)

plt.title("Histogram Example")
plt.xlabel("Values")
plt.ylabel("Counts")

fig = plt.figure()
fig.savefig("histogram.png")
