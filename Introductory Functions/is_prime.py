import math


# Modify the following function so that it determines whether b is a factor of a
# The statement "return False" is just a placeholder - you should replace it.
def is_factor(a, b):
    ''' 
    Returns True if 'b' is a factor of 'a'. Assumes arguments 'a' and 'b' 
    to be in the set of positive integers.
    '''
    if a % b == 0:
        return True
    
    else:
        return False


# Modify the following function definition so that it determines whether
# n is a prime number or not.
# The statement "return False" is just a placeholder - you should replace it.
def is_prime(n):
    ''' 
    Returns True if 'n' is prime. Assumes argument to be in the set
    of integers that are greater than 1.
    '''
    i = 2
    x = 0
    
    while i < n:       
        if is_factor(n,i) == True:
            x = x + 1
            
        i = i + 1

    if x == 0:
        return True
    
    else:
        return False

    
# Modify the following function definition so that it determines whether n can
# be expressed in the form p ** 2, where p is a prime number.
# The statement "return False" is just a placeholder - you should replace it.
def is_prime_squared(n):
    ''' 
    Returns True if 'n' is the square of a prime. Assumes argument to be
    in the set of integers that are greater than 1.
    '''  
    p = n**(0.5)
    
    if p == int(p) and is_prime(p) == True:
        return True
    
    else:
        return False


# REMEMBER THAT THIS FILE (WHEN YOU SUBMIT IT) MUST NOT CONTAIN ANYTHING
# OTHER THAN YOUR FUNCTION DEFINITIONS AND COMMENTS.
# YOU MAY NOT IMPORT ANY MODULES OTHER THAN THE 'math' MODULE
