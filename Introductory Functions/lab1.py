def any_one_is_sum1(a,b,c):
    sum_c=a+b
    sum_b=a+c
    sum_a=b+c
    if sum_c == c:
        return True
    elif sum_b == b:
        return True        
    elif sum_a == a:
        return True
    else:
        return False


def any_one_is_sum2(a,b,c):
    if b + c == a:
        return True
    elif c + a == b:
        return True
    elif a + b == c:
        return True
    else:
        return False


def any_one_is_sum3(a, b, c):
    if a+b==c or a+c==b or b+c==a:
        return True
    else:
        return False
        
    
def sum_odd_digits(number):
    dsum = 0
    k = len(str(number))
    # only count odd digits
    while k>0:
        if number % 2 != 0:
        # add the last digit to the sum
            digit = number % 10
            dsum = dsum + digit
        # divide by 10 (rounded down) to remove the last digit
        number = number // 10
        k=k-1
    return dsum


def sum_even_digits(number):
    m = 1 # the position of the next digit
    dsum = 0 # the sum
    while number % (10 ** m) != 0 and m<len(str(number)):
        # get the m:th digit
        digit = (number % (10 ** m)) // (10 ** (m - 1))
        # only add it if even:
        if digit % 2 == 0:
            dsum = dsum + digit
        m = m + 1
    return dsum


def mystery(m):
    assert type(m) is int and m >= 0, "m must be a non-negative integer"
    while m > 1:
        i = 2
        while i < m:
            while m % i == 0:
                m = m // i
            i = i + 1
    return i


def count_negative(sequence):
    count = 0
    index = 0
    while index < len(sequence):
        if sequence[index] < 0:
            count = count + 1
        index = index + 1
    return count


def count_negative1(sequence):
    count = 0
    for i in sequence:
        if sequence[i] < 0:
            count = count + 1
    return count

    
def is_increasing(sequence):
    count = 0
    for i in range(len(sequence)-1):
            if sequence[i] > sequence[i+1]:
                count = count + 1
    if count == 0:
        return True
    else:
        return False
    
    
def is_increasing1(sequence):
    count = 0
    i = 0
    while i < len(sequence) - 1:
        if sequence[i] > sequence[i+1]:
            count = count + 1
        i = i + 1
    if count == 0:
        return True
    else:
        return False
    
    
def most_average(numbers):
    mean = sum(numbers) / len(numbers)
    diff = abs(numbers[0] - mean)
    index = numbers[0]
    for i in range(1, len(numbers) - 1):
        if abs(numbers[i] - mean) < diff:
            diff = abs(numbers[i] - mean)
            index = numbers[i]
    return index


def find_element(sequence, element):
    i = 0
    x = 0
    while i < len(sequence):
        if sequence[i] == element:
            x = x + 1
            return i
        i = i + 1
    if x == 0:
        return len(sequence)
    

def smallest_greater(sequence, value):
    seq = sorted(sequence + [value])
    x = 0
    while x < len(seq) - 1:
        if seq[x] == value:
            return seq[x + 1]
        x = x + 1

def greatest_smaller(sequence, value):
    seq = sorted(sequence + [value])
    x = 1
    while x < len(seq):
        if seq[x] == value:
            return seq[x - 1] 
        x = x + 1
        

def count_in_bin(values, lower, upper):
    left_count = 0
    mid_count = 0
    right_count = 0
    
    for i in values:
        if min(values) <= values[i] <= lower:
            left_count = left_count + 1
            
        elif lower < values[i] <= upper:
            mid_count = mid_count + 1
            
        elif upper < values[i] <= max(values):
            right_count = right_count + 1
            
    return print('left:', left_count, 'mid:', mid_count, 'right:', right_count)


def histogram(values,dividers):
    bins = [0 for x in range(len(dividers) + 1)]
    for num in values:
        if num > dividers[-1]:
            bins[-1] += 1
        else:    
            k = 0
            while num > dividers[k]:
                k += 1
            bins[k] += 1               
    return bins                

print(histogram(range(20),[2,4,9]))

    
def count_duplicates(seq):
    sort = sorted(seq)
    print(sort)
    count = 0 
    k = 0
    for i in range(0,len(sort)-1): 
        if sort[i] == sort[k+1]:
            count += 1
        k += 1    
    return count

import random as rnd
seq = [rnd.randint(0,100) for i in range(50)]

    
    