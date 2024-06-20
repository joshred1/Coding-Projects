def max_relative_frequency(string):
    '''
    Computes the the proportion of the most frequently 
    occurring letter to the total number of letters in the 
    string. Assumes argument is of type 'str'.
    
    '''
    assert type(string) == str
    #Create placeholder list for number of occurences of each letter of the alphabet in order:
    count_list = []
    #Convert all letters in string to lower-case as count isn't case-sensitive, and iterate through all letters alphabetically:
    for i in range(97,123):
        count = string.casefold().count(chr(i))
    #Add number of occurences of each letter to count_list:
        if count > 0:
            count_list.append(count)
    #Change elements for letters with no occurences to 0 rather than the default -1. This will be useful for finding the total number of valid letters:
        else:
            count_list.append(0)
    #Undefined case 0/0 must return 0. Otherwise, return the true relative frequency:
    if sum(count_list) == 0:
        return 0.0
    else:
        return max(count_list)/sum(count_list)