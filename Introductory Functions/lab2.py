def count_capitals(str):
    count = 0
    for letter in str:
        if 65 <= ord(letter) <= 90:
            count += 1
    return count


def count(seq, X):
    count = 0
    for i in seq:
        if X is true:
            count += 1
    return count


my_list = [i+1 for i in range(26)]


def count_repetitions(string, substring):
    '''
    Count the number of repetitions of substring in string. Both
    arguments must be strings.
    '''
    n_rep = 0
    # p is the next position in the string where the substring starts
    p = string.find(substring)
    # str.find returns -1 if the substring is not found
    while p >= 0:
        n_rep = n_rep + 1
        # find next position where the substring starts
        string = string[p+len(substring):]
        p = string.find(substring)
    return n_rep


def remove_substring_everywhere(string, substring):
    '''
    Remove all occurrences of substring from string, and return
    the resulting string. Both arguments must be strings.
    '''
    p = string.find(substring)

    while p >= 0:
        string = string[:p] + string[p+len(substring):]
        p = string.find(substring)
    return string


def encrypt(str, shift):
    my_list = list(str)
    for i in range(len(my_list)):
        if shift < 0 or shift > 26:
            shift = shift%26
        if 65 <= ord(str[i]) <= 90 - shift or 97 <= ord(str[i]) <= 122 - shift:
            encode = ord(str[i]) + shift
            my_list[i] = chr(encode)
        if 90 - shift < ord(str[i]) <= 90 or 122 - shift < ord(str[i]) <= 122:
            encode = ord(str[i]) - 26 + shift
            my_list[i] = chr(encode)
    delimiter = ''
    return delimiter.join(my_list)


def decipher(encrypted):
    count_list = []
    for i in range(0,26):
        message = encrypt(encrypted,i)
        count = 0
        listed_message = message.casefold().split()
        for j in listed_message:
            if j in ['the','and','for','are','but','not','you','all','any','can','her','was','one','our','out','day','get','has','him','his','how','man','new','now','old','see','two','way','who','boy','did','its','let','put','say','she','too','use','dad','mom']:
                count += 1
        count_list.append(count)
    max_count = count_list.index(max(count_list))
    if max_count == 0:
        count_list = []
        for i in range(1, 26):
            message = encrypt(listed,i)
            count = 0
            listed_message = message.casefold().split()
            for j in listed_message:
                if j == 'e':
                    count += 1
            count_list.append(count)
        max_count = count_list.index(max(count_list))
    return encrypt(encrypted, max_count)


def pig_latin(str):
    listed_str = str.casefold().split()
    for i in range(len(listed_str)):
        if listed_str[i][0] in ['a','e','i','o','u']:
            listed_str[i] += 'yay'
        else:
            while listed_str[i][0] not in ['a','e','i','o','u']:
                rm_letter = listed_str[i][0]
                listed_str[i] = listed_str[i][1:]
                listed_str[i] += rm_letter
            listed_str[i] += 'ay'
    delimiter = ' '
    return delimiter.join(listed_str)


