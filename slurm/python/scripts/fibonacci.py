# A very inefficient program to print the first n Fibonacci numbers

def fib(n):
	if (n == 0):
		return 0
	elif (n == 1):
		return 1
	else:
		return (fib(n-1) + fib(n-2))

for i in range(34):
	print("When n={}, fib(n)={}".format(i, fib(i)))
