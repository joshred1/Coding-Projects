# -*- coding: utf-8 -*-
"""
Lab 0: Introduction to Python

Joshua Redolfi 
"""

#Lab Book: Write code which calculates the sum 1 + 2 + · · · + n using a ‘for’ loop (where the value of n is saved in a variable n. Check your code by comparing with the true value n(n + 1)/2.

x = 10
n = 0
for i in range(11):
    print(i)
    n += i
print(n)
print(n == x*(x+1)/2)

def ex(x):
    """
    Calculate the exponential e^x using a Taylor series.
    """
    ans = 0
    n = 1
    term = 1
    while ans + term != ans:
        ans = ans + term
        term = term * (x / n)
        n = n + 1
    return ans

#Lab Book: Using this program, what is the approximation to e^1, e^10 and e^−10. What are some techniques you might use to check the output?

print(ex(1))
print(ex(10))
print(ex(-10))

import math
print(abs(ex(1) - math.exp(1)) <  1e5)
print(abs(ex(10) - math.exp(10)) <  1e5)
print(abs(ex(-10) - math.exp(-10)) <  1e5)

#When writing code to implement Taylor series expansions we can’t sum to ∞. Explain what has been done in the above code to get around this problem.

#Set a tolerance of 1e5.

mylist = [1, 4, 9, 16, 25, 36, 49]

#Lab Book: What slice returns mylist without the first and last elements (i.e. the slice is [4, 9, 16, 25, 36])?

mylist[1:len(mylist)-1]

#Lab Book: How accurate is the ex function defined earlier compared to the math.exp function? Try evaluating ex(x) and exp(x) for values of x from −20 to 20. We will study these differences later in the section on floating point numbers.

for x in range(-20,21):
    print(x)
    print(abs(ex(x) - math.exp(x)))
    
#Lab Book: Write a function phi which calculates Φ(x). Then, write a function european_call which takes in the inputs K, S, T, r and σ, and returns the price C. What is the price of a European call option with K = 90, S = 100, r = 0.03, T = 0.5 and σ = 0.1? Does the price C increase or decrease as σ increases?

def phi(x):
    """
    Calculates the cumulative distribution function for a standard normal
    variable.
    """
    return (1+math.erf(x/math.sqrt(2)))/2

def european_call(K,S,T,r,sigma):
    """
    Calculates the price of a european call option using the Black Scholes
    equation.

    Parameters
    ----------
    K : Strike price (float)
    S : Current share price (float)
    T : Time to maturity (float)
    r : Current interest rate (float)
    sigma : Volatility (float)

    Returns call price rounded to 2dp (float)
    -------
     
    """
    d1 = (math.log(S/K) + (r + sigma**2/2)*T)/(sigma*math.sqrt(T))
    d2 = d1 - sigma*math.sqrt(T)
    C = phi(d1)*S - phi(d2)*K*math.exp(-r*T)
    return round(C,2)

print(european_call(90, 100, 0.5, 0.03, 0.1))

i = 0.05
while i < 1:
    print(i)
    print(european_call(90, 100, 0.5, 0.03, i))
    i += 0.05
    
#price increases as volatility increases.

def current(RL,V,RS):
    """
    Calculate the current given the voltage source with voltage V
    and internal resistance RS supplying a load of resistance RL.
    Input: RL = load of resistance (list of floating-point numbers)
    : V = Voltage (floating-point number)
    : RS = internal resistance (floating-point number)
    Output: current (list of floating-point numbers)
    """
    n = len(RL)
    I = n*[0.0] # I is a list with the same size as RL
    for j in range(n):
        I[j] = V / (RL[j] + RS)
    return I

RL = list(range(1,6))
I = current(RL, 1.0, 0.0)
print(I)

#Lab Book: Is the output produced by the above code correct? Why or why not? If it is not correct, what modifications must be made to the code to correct it?

#Lab Book: Write a function power which takes in a list of currents I and resistance loads RL, and returns a list of values of PL given by the formula above. Test your power function by running:
    
def power(I,RL):
    """
    Calculates the power supplied to the load resistance.

    Parameters
    ----------
    I : List of currents
    RL : List of resistance loads

    Returns list of values of PL
    -------

    """
    PL_list = []
    for j in range(len(I)):
        PL = RL[j]*(I[j])**2
        PL_list.append(PL)
    return PL_list


RL = list(range(1, 6))
I = current(RL, 1.0, 0.0)
PL = power(I, RL)
print(PL)

import matplotlib.pyplot as plt
def power_plot(RL, PL):
    """
    Plot the power PL versus the load of resistance RL.
    Input: RL = load of resistance (list)
    : PL = power (list)
    Output: none
    """
    plt.clf()
    plt.plot(RL, PL)
    plt.title('Plot of power versus load resistance')
    plt.xlabel('Load resistance (Ohms)')
    plt.ylabel('Power (Watts)')
    plt.grid()
    plt.show()
    return

# Set the internal resistance to 50 Ohms
RS = 50.0
# Set the voltage source to 120V
V = 120.0
# Create a list of possible values for the load resistance
RL = list(range(1, 101))
# Calculate the current and power
I = current(RL, V, RS)
PL = power(I, RL)
# Plot the power versus load resistance
power_plot(RL, PL)

#Lab Book: By using list indexing/slicing, find the value of PL corresponding to this optimal value of RL.
    
RL[PL.index(max(PL))]
max(PL)