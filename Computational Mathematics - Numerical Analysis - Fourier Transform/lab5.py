# -*- coding: utf-8 -*-
"""
Fourier Transform, ODEs

@author: Joshua
"""

import numpy as np
import pandas as pd 
import cmath as m 
import matplotlib.pyplot as plt
import time
from scipy import integrate 

#Lab Book: Write a function which creates the Fourier transform matrix F_n (for any input n, not necessarily a power of 2).1 For n = 10, use suitable norms to verify that F_n is symmetric and that F_n\bar{F}_n = nI.

def DFT(n):
    w = m.exp(-2*m.pi*1j/n)
    F = np.zeros((n,n), dtype = "complex")
    for i in range(n):
        for j in range(n):
            F[i,j] = w**(i*j)
    return F

F = DFT(10)            

#if Fn is symmetric, then the max column sum of F should equal the max row sum of F^T. Thus comparing the L-1 and L-infinity norms of F we have:
    
np.linalg.norm(F, ord=1) == np.linalg.norm(F.T, ord=np.inf)

#Also by visual inspection, it is clear that the matrix is symmetrix

Fconj = np.conj(F)
I = F@Fconj
np.linalg.norm(I-10*np.eye(10), ord="fro")

#the error is extremely small and also from visual inspection its clear that F_n\bar{F}_n = nI holds.



#Lab Book: For n = 1, 2, 4, 8, 16, . . . , 8192 (or less if it takes too long), plot the runtime of (a) building the matrix Fn using your code above; (b) calculating the DFT of x = (1, 2, 3, . . . , n)^T using matrix-vector multiplication (not including creating the matrix Fn); and (c) calculating the same DFT using NumPy’s FFT function. See lab 4 for code which can measure runtime. Discuss whether your results match the expected results from theory.

#a
Ftime = []
ntime = []
for n in range(14):
    t_start = time.time()
    Fn = DFT(2**n)
    t_end = time.time()
    Ftime.append(t_end - t_start)
    ntime.append(2**n)
 
plt.figure()
plt.clf()
plt.plot(ntime, Ftime)
plt.grid()
plt.xlabel('n')
plt.ylabel('time (seconds)')
plt.title('Computation time for DFT')
plt.show()

#b
DFTtime = []
ntime = []
for n in range(14):
    x = np.arange(1,1 + 2**n, dtype = 'complex')
    Fn = DFT(2**n)
    t_start = time.time()
    xhat = Fn@x
    t_end = time.time()
    DFTtime.append(t_end - t_start)
    ntime.append(2**n)

#c
FFTtime = []
ntime = []
for n in range(14):
    x = np.arange(1,1 + 2**n, dtype = 'complex')
    t_start = time.time()
    xhat = np.fft.fft(x)
    t_end = time.time()
    FFTtime.append(t_end - t_start)
    ntime.append(2**n)
 
plt.figure()
plt.clf()
plt.plot(ntime, DFTtime)
plt.grid()
plt.xlabel('n')
plt.ylabel('time (seconds)')
plt.title('Computation time for DFT(x)')
plt.show()

#The time function is quadratic in shape, which is consistent with the theory that the method computes O(n^2) flops.

plt.figure()
plt.clf()
plt.plot(ntime, FFTtime)
plt.grid()
plt.xlabel('n')
plt.ylabel('time (seconds)')
plt.title('Computation time for FFT(x)')
plt.show()

#The time function appears flat. The theory states that the FFT involves O(n*log n) computations, which if we were to plot such function, would be increasing but at an almost linear rate. I would say that the matrix size is small enough that the computatiion time is almost zero, and so we cannot identify from the graph the n*log n trend, however if we were to compute FFT of much larger matrices, then the computation time would be evidently consistent with the theory.



#Lab Book: Looking at your plots, pick a magnitude which is slightly larger than the typical ‘noise’ contribution, but much smaller than the size of any spikes. Modify the DFT of noisy_data by setting to zero all entries with magnitude less than your chosen level, and calculate the inverse DFT to produce a ‘denoised’ signal (you will have to look up how to calculate an inverse DFT in NumPy). Produce a plot the original signal, noisy signal and your denoised signal and check that you have removed a reasonable amount of the noise. Quantitatively compare the error (versus data) of the noisy and your denoised signal using suitable norms, to check that your denoised signal is closer to the true data than noisy_data.

data = np.loadtxt('lab5_piano_data.csv', delimiter=',')
time = np.linspace(0.0, 1.0, len(data)) # data represents 1 second of audio
print("CSV has a vector of size =", data.shape)

N = data.size
freq = range(N+1)

#FFT of first 2000 data entries
plt.figure()
plt.clf()
plt.plot(freq[0:1000], np.abs(np.fft.fft(data))[0:1000])
plt.xlabel("frequency (Hertz)")
plt.ylabel("Amplitude")
plt.title("FFT of Piano Middle C Sound Wave")
plt.grid()
plt.show()

np.random.seed(0) # produce the same random numbers every time the code is run (optional)
noisy_data = data + 0.005 * np.random.randn(len(data)) # perturb data with random noise

noisy_DFT = np.abs(np.fft.fft(noisy_data))

plt.figure()
plt.clf()
plt.plot(freq[0:1000], noisy_DFT[0:1000])
plt.xlabel("frequency (Hertz)")
plt.ylabel("Amplitude")
plt.title("FFT of Noisy Data")
plt.grid()
plt.show()

modified_DFT = np.fft.fft(noisy_data)
modified_DFT[np.abs(modified_DFT)<5] = 0
denoised_data = np.fft.ifft(modified_DFT)

plt.figure()
plt.clf()
plt.plot(time[0:1000], data[0:1000], linestyle = '--')
plt.plot(time[0:1000], denoised_data[0:1000])
plt.xlabel("time (seconds)")
plt.ylabel("Amplitude")
plt.title("Piano Middle C Sound Wave")
plt.legend(['Original signal', 'De-noised signal'],loc='best')
plt.grid()
plt.show()

plt.figure()
plt.clf()
plt.plot(time[0:1000], noisy_data[0:1000], linestyle = ':')
plt.plot(time[0:1000], denoised_data[0:1000])
plt.xlabel("time (seconds)")
plt.ylabel("Amplitude")
plt.title("Piano Middle C Sound Wave")
plt.legend(['Noisy signal', 'De-noised signal'],loc='best')
plt.grid()
plt.show()

#Quantitative comparison between noisy and de-noised data:
np.linalg.norm(noisy_data - data) > np.linalg.norm(denoised_data - data)

#Returns true, thus the error between denoised data and the original signal is smaller than the error between the noisy data and original signal, and hence the filter improves the fit.



#Lab Book: Show that the formula for u(t) solves the ODE

P = 10000; c = 0.2
t = np.linspace(-1000,1,1000)

#Create solution u(t):
def utrue(t):
    u = 1/(1+(P-1)*np.exp(-c*t))
    return u 

#Create LHS and RHS of the logistic ODE:
RHS = c*utrue(t)*(1-utrue(t))
h = 10e-10
LHS =  (utrue(t+h)-utrue(t-h))/(2*h)

#Verify solution:
np.linalg.norm(LHS-RHS)

#error is 1.215e-11 which is extremely small thereby verifying that u(t) solves the ODE. We can also confirm that it satisfied the initial condition:

utrue(0) == 1/P    



#Lab Book: Modify the above code to implement our ODE (f and u0) for time horizon T = 100 days. Then, implement the one-step methods: explicit Euler, Heun’s method and the classical 4th order Runge-Kutta scheme (RK4). For n = 200, plot your three computed solutions against the true solution u(t). Interpret the solution to this ODE in terms of the application setting (infectious disease).

# RHS of the ODE
def f(t, u):
    return c*u*(1-u) 

# One-step method: Explicit Euler Method
def phi1(t, u, h):
    return f(t, u) 

# One-step method: Heun Method
def phi2(t, u, h):
    return 0.5*f(t, u) + 0.5*f(t + h, u + h*f(t, u)) 

# One-step method: RK4 Method
def phi3(t, u, h):
    k1 = f(t, u)
    k2 = f(t + h/2, u + h*k1/2)
    k3 = f(t + h/2, u + h*k2/2)
    k4 = f(t + h, u + h*k3)
    return (k1 + 2*k2 + 2*k3 + k4)/6 

u0 = 1/P # initial condition
T = 100 # end time
n = 200 # use n+1 equally spaced time steps
ts = np.linspace(0, T, n+1) # vector of timesteps, tk = ts[k]
h = T / n # gap between timesteps
u = np.zeros((n+1,)) # create an empty vector for our solution
u[0] = u0 # set initial condition

# Run each of the one-step methods

plt.figure()
plt.clf()
u = np.zeros((n+1,)) 
u[0] = u0 
for k in range(n):
    u[k+1] = u[k] + h * phi1(ts[k], u[k], h)
plt.plot(utrue(ts), u)
u = np.zeros((n+1,)) 
u[0] = u0     
for k in range(n):
    u[k+1] = u[k] + h * phi2(ts[k], u[k], h)   
plt.plot(utrue(ts), u)
u = np.zeros((n+1,)) 
u[0] = u0     
for k in range(n):
    u[k+1] = u[k] + h * phi3(ts[k], u[k], h)   
plt.plot(utrue(ts), u, linestyle = '--')
plt.xlabel("true solution")
plt.ylabel("Numerical Solution")
plt.legend(["Explicit Euler", "Heun Method", "RK4"], loc = "best")
plt.grid()
plt.show() 

#Plotting the numerical solutions against the true solution, it is clear that the Explicit Euler method is far less accurate then the othet two methods, which match almost identically. 

plt.figure()
plt.clf()
plt.plot(ts, utrue(ts))
plt.xlabel("time (days)")
plt.ylabel("u(t)")
plt.title("Disease Spread over Time")
plt.grid()
plt.show() 

#Plotting the true solution wrt time, we see that initially, the disease is slow to spread, however as the disease moves the population, it has a compounding effect which causes an exponential growth in the number of infected individuals in the population. As the time goes on, the disease hits capacity and thus spread slows down as shown by the flattening of the curve.



#Lab Book: For n = 50, 100, 200, 400, 800, 1600 and each of the three one-step methods, produce a table similar to slide 41 of the ODE lectures, computing the maximum absolute error |uk − u(tk)| at any time step tk for each method. From your table, determine what order of convergence you are seeing in each method and compare this to the theory in lectures

Euler_error = []
Heun_error = []
RK4_error = []
nlist = [50,100,200,400,800,1600]
hlist = [100/n for n in nlist]

for n in nlist:
    ts = np.linspace(0, T, n+1) 
    h = T / n 

    u = np.zeros((n+1,))
    u[0] = u0 
    for k in range(n):
        u[k+1] = u[k] + h * phi1(ts[k], u[k], h)
    Euler_error.append(max(abs(utrue(ts) - u)))

    u = np.zeros((n+1,))
    u[0] = u0 
    for k in range(n):
        u[k+1] = u[k] + h * phi2(ts[k], u[k], h)
    Heun_error.append(max(abs(utrue(ts) - u)))

    u = np.zeros((n+1,))    
    u[0] = u0 
    for k in range(n):
        u[k+1] = u[k] + h * phi3(ts[k], u[k], h)
    RK4_error.append(max(abs(utrue(ts) - u)))

dframe = pd.DataFrame({"n": nlist, "h": hlist, "Euler": Euler_error, "Heun": Heun_error, "RK4": RK4_error})  
print(dframe)  

#as h=2^k decreases by k from k=1 to k=-4, The error in explicit Euler halves, which is consistent with O(h). Error corresponding to Heun method is quartered (2^-2), which is consistent with O(h^2). Lastly, RK4 error term decreases by a factor of 1/16 (2^-4), and is thereby consistent with O(h^4). All 3 error convergences are consistent with the results shown in the lectures.



#Lab Book: Use solve_ivp with RK45 to solve the original and our new ODE and plot the two solutions. How many people are healthy after 100 days under the two scenarios? How many extra people would be healthy at day 100 if we started vaccinating on day t = 0 rather than day t = 5?

# RHS of the ODE
def f1(t, u):
    return c*u*(1-u)

u0 = np.array([1/P]) # initial condition (must be a NumPy array)
T = 100 # end time

sol = integrate.solve_ivp(f1, [0, T], u0, t_eval = np.linspace(0,T,201))

# RHS of the ODE
def g(t, u):
    return c*u*max(1 - u - 0.01*max(t-5,0), 0)

sol1 = integrate.solve_ivp(g, [0, T], u0, t_eval = np.linspace(0,T,201))

# RHS of the ODE
def g2(t, u):
    return c*u*max(1 - u - 0.01*max(t,0), 0)

sol2 = integrate.solve_ivp(g2, [0, T], u0, t_eval = np.linspace(0,T,201))

plt.figure()
plt.clf()
plt.plot(sol.t, sol.y[0])
plt.plot(sol1.t, sol1.y[0])
plt.plot(sol1.t, sol2.y[0])
plt.xlabel("time (days)")
plt.ylabel("u(t)")
plt.legend(["No vaccinations", "Vaxinations from day 5", "Vaxinations from day 0"],loc = "best")
plt.grid()
plt.show() 

#Under the no-vaccination scheme, by day 100 just about the entire population (99.99%) is sick, whereas if we had vaccinations from day 5, that number reduces drastically to just 36.041%. If instead we start vaccinations from day 0, this will further reduce the number of sick people on day 100 by almost another 10% to just 27.89% of the population. That equates to an extra 10000*(0.36041-0.2789)=815 healthy people.



#Lab Book: Solve this system of ODEs using the explicit Euler method, uk+1 = uk + ∆t f(t,uk) for some time discretisation ∆t. Using data a = b = 0, c = 1 and f(x) = sin(πx), plus spatial discretisation n = 10 and time step ∆t = 0.5/n2, plot the solution u(t, x) versus x for t = 0, 0.1, 0.2, . . . , 0.5. 

n = 10
dx = 1/n
dt = 0.5/(n**2)
a = 0; b = 0; c = 1
xs = np.arange(0,1+dx,dx)
ts = np.arange(0,1+dt,dt)
u = np.zeros((len(ts)+1,len(xs))) #u=u(t,x)

def u0(x):
    return np.sin(np.pi*x)

for j in range(len(xs)):    
    u[0,j] = u0(xs[j]) 

def func(x, u):
    if x == min(xs):
        return a
    elif x == max(xs):
        return b
    elif min(xs) < x < max(xs):
        return c*(u[k,j-1] - 2*u[k,j] + u[k,j+1])/(dx**2)

for k in range(len(ts)):    
    for j in range(len(xs)):    
        u[k+1,j] = u[k,j] + dt*func(xs[j], u)
        
plt.figure()
plt.clf()
for k in range(len(ts)):
    if ts[k] in [0,0.1,0.2,0.3,0.4,0.5]:
        plt.plot(xs, u[k,])
plt.xlabel("x")
plt.ylabel("u(t,x)")
plt.legend(["t=0","t=0.1","t=0.2","t=0.3","t=0.4","t=0.5"],loc="best")
plt.show() 



#Lab Book: With this choice of f(x), plot the solution after 500 iterations for ∆t = α/n2 where α ∈ {0.48, 0.5, 0.52}. What do you observe?    

n = 10
dx = 1/n
a = 0.5; b = -0.5; c = 1
xs = np.arange(0,1+dx,dx)

def v0(x):
    return 0.5 - x

def func(x, v):
    if x == min(xs):
        return a
    elif x == max(xs):
        return b
    elif min(xs) < x < max(xs):
        return c*(v[k,j-1] - 2*v[k,j] + v[k,j+1])/(dx**2)

plt.figure()
plt.clf()
for alpha in [0.48, 0.5, 0.52]:
    dt = alpha/(n**2)
    ts = np.arange(0,5+dt,dt)
    v = np.zeros((len(ts)+1,len(xs)))
    for j in range(len(xs)):    
        v[0,j] = v0(xs[j]) 
    for k in range(len(ts)):    
        for j in range(len(xs)):    
            v[k+1,j] = v[k,j] + dt*func(xs[j], v)
    plt.plot(xs, v[500,])
plt.xlabel("x")
plt.ylabel("v(t,x)")
plt.legend(["alpha=0.48","alpha=0.5","alpha=0.52"],loc="best")
plt.show() 

#The plot of v(x) at t=500 remains stable as alpha change (and thereby the time discretisation) changes. However if we perturb alpha by just +0.02 units, then the solution blows up:
    
plt.figure()
plt.clf()
for alpha in [0.48, 0.5, 0.52, 0.54]:
    dt = alpha/(n**2)
    ts = np.arange(0,5+dt,dt)
    v = np.zeros((len(ts)+1,len(xs)))
    for j in range(len(xs)):    
        v[0,j] = v0(xs[j]) 
    for k in range(len(ts)):    
        for j in range(len(xs)):    
            v[k+1,j] = v[k,j] + dt*func(xs[j], v)
    plt.plot(xs, v[500,])
plt.xlabel("x")
plt.ylabel("v(t,x)")
plt.legend(["alpha=0.48","alpha=0.5","alpha=0.52","alpha=0.54"],loc="best")
plt.show() 