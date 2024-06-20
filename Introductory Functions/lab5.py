a = {0: 'none', 1: 'one', 2: 'two', 3: 'many'}
type(a)
b = { 'one', 'two', 'many' }
type(b)
c = {}
a[3] = 'three'

wordlist = ['test', 'your', 'function', 'with', 'a', 'diverse',
 'range', 'of', 'examples', 'your', 'tests', 'should', 'cover',
 'all', 'cases', 'for', 'example', 'test', 'words', 'beginning',
 'with', 'a', 'vowel', 'and', 'word', 'beginning', 'with', 'a',
 'consonant', 'pay', 'particular', 'attention', 'to', 'edge',
 'cases', 'for', 'example', 'what', 'happens', 'if', 'the',
 'word', 'consists', 'of', 'just', 'one', 'vowel', 'like',
 'a', 'what', 'happens', 'if', 'the', 'string', 'is', 'empty']

wordlen = {word:len(word) for word in wordlist}
wordset = set(wordlist)

def histogram(seq):
    count = dict()
    for elem in seq:
        if elem not in count:
            count[elem] = 1
        else:
            count[elem] += 1
    return count

numbers = { 0 : 'none', 1 : 'one', 2 : 'two', 3 : 'many', 4 : 'many',
            5 : 'many', 6 : 'a few more than many', 7 : 'a lot of',
            8 : 'really many', 9 : 'too many to count' }

for key in numbers.keys():
    print(key, ':', numbers[key])

for item in numbers.items():
    key, value = item #shorthand for key[0] value[1] if key,value is a length two sequence
    print(key, ':', value)

def invert_dictionary(d):
    import numpy as np
    assert len(list(d.values())) == len(np.unique(list(d.values()))),"values aren't unique"
    inverse_list = []
    for item in d.items():
        key,value = item
        inverse_list.append([value,key])
        inverse_d = dict()
        for i in range(len(inverse_list)):
            inverse_d[inverse_list[i][0]] = inverse_list[i][1]
    return inverse_d

def invert_dictionary1(d):
    inverse_list = []
    key_list = []
    value_list = []
    unique_values = []
    unique_keys = []
    for key in d.keys():
        key_list.append(key)
    for value in d.values():
        value_list.append(value)
    for i in range(len(value_list)):
        pos_list = []
        if value_list.count(value_list[i]) == 1:
            unique_values.append(value_list[i])
            print(unique_values)
        else:
            pos_index = 0
            while pos_index < len(value_list):
                if value_list[i] == value_list[pos_index]:
                    pos_list.append(pos_index)
                    print(pos_list)
                pos_index += 1
                print(pos_index)
            unique_values.append(pos_list)
    for i in range(len(unique_values)):
        if type(unique_values[i]) != list:
            unique_keys.append(key_list[unique_values[i]])
        else:
            pos_list = []
            for j in range(len(unique_values[i])):
                pos_list.append(key_list[unique_values[i][j]])
            unique_keys.append(pos_list)
    for i in range(len(unique_values)):
        if type(unique_values[i]) != list:
            value1 = value_list[unique_values[i]]
        else:
            value1 = value_list[unique_values[i][0]]
        keyset = set(unique_keys[i])
        inverse_list.append([value1, keyset])
    inverse_d = dict()
    for i in range(len(inverse_list)):
        inverse_d[inverse_list[i][0]] = inverse_list[i][1]
    return inverse_d

