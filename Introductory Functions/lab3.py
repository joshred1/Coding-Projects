#1.
row1=["H","He"]
row2=["Li","Be","B","C","N","O","F","Ar"]
row3=["Na","Mg","Al","Si","P","S","Cl","Ne"]
ptable=row1
ptable.extend(row2)
ptable.extend(row3)
row2[7] = 'Ne'
row3[7] = 'Ar'
id(row1)
id(row2)
id(row3)
id(ptable)

row1 = ["H","He"]
row2 = ["Li","Be","B","C","N","O","F","Ar"]
row3 = ["Na","Mg","Al","Si","P","S","Cl","Ne"]
ptable = [row1]
ptable.append(row2)
ptable.append(row3)
ptable[1][5]
ptable[2][1]
row2[7] = 'Ne'
row3[7] = 'Ar'
id(row1) == id(ptable[0])

row2=['Li', 'Be', 'B', 'C', 'N', 'O', 'F', 'Ar']
ptable1=["H","Xe",row2]
ptable2 = ptable1[:]  #shallow copy
ptable2[2][7] = 'Ne'

row2=['Li', 'Be', 'B', 'C', 'N', 'O', 'F', 'Ar']
ptable1=["H","Xe",row2]
import copy
ptable2=copy.deepcopy(ptable1) #deep copy
ptable2[2][7] = 'Ne'

#2.
def make_list_of_lists(n):
    the_list = []
    sublist = []
    while n > 0:
        the_list.append(sublist[:])
        sublist.append(len(sublist) + 1)
        n = n - 1
    return the_list

def make_list_of_lists2(n):
    the_list = []
    sublist = []
    for i in range(1,n+1):
        the_list.append(sublist[:])
        sublist.insert(len(sublist), i)
    return the_list


def allbut(list,index):
    list.pop(index)
    print(list)

def slice_in_place(list,start,end):
    alist = []
    for i in range(start,end +1 ):
        alist.append(list[i])
    return alist

def perfect_shuffle(list):
    list_a = []
    list_b = []
    n = 0
    while n < len(list):
        list_a.append(list[n])
        n += 2

    for i in range(len(list)):
        if list[i] not in list_a:
            list_b.append(list[i])
    return list_a + list_b

def perfect_shuffle_in_place(list):
    newlist = perfect_shuffle(list)
    print(newlist)
    count = 1
    while newlist != list:
        newlist = perfect_shuffle(newlist)
        print(newlist)
        count += 1
    return count

def nesting_depth(my_list):
    depth = 0
    #repeat loop until no more list elements in list=flatlist:
    while len(my_list) != 0:
        # create new list with nested list elements:
        newlist = []
        for i in range(len(my_list)):
            if type(my_list[i]) == list:
                newlist.append(my_list[i])
        flatlist = []
        if len(newlist) > 0:
            depth += 1
            #separate each element:
            for i in range(len(newlist)):
                for j in range(len(newlist[i])):
                    flatlist.append(newlist[i][j])
        #set flatlist as the original list and repeat loop
        my_list = flatlist
    return depth

def diagonality(matrix):
    d_list = []
    for i in range(len(matrix)):
        for j in range(len(matrix[i])):
            if matrix[i][j] != 0:
                d_list.append(abs(i-j))
    return max(d_list) + 1

def min_diagonality(matrix):
    from itertools import permutations as p
    list_of_d_lists = []
    p_list = list(p(matrix))
    for i in range(len(p_list)):
        a_list = list(p_list[i])
        list_of_d_lists.append(diagonality(a_list))
    return min(list_of_d_lists)

def f(x):
    from math import exp
    return exp(x)

def diff_f(x,d = 1e-6):
    slope = (f(x + d) - f(x - d)) / (2 * d)
    return slope

def diff_erf(x,d = 1e-6):
    error = abs(diff_f(x,d) - f(x))
    return error

def plot_error(x):
    from math import log
    ds = [10**(-i) for i in range(2,16)]
    erfx = [log(diff_erf(x,ds[j])) for j in range(len(ds))]
    from matplotlib import pyplot as pt
    pt.plot(ds,erfx)
    return pt.show()