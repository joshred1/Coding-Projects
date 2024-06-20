def line_count(path,file):
    import os
    os.chdir(path)
    file_obj = open(file,'r')
    count = 0
    for line in file_obj:
        if line.strip() != "":
            count += 1
    file_obj.close()
    return count

def read_backwards(path,file):
    import os
    os.chdir(path)
    file_obj = open(file, 'r')
    pos_list = []
    for line in file_obj:
        pos_list.append(line)
    file_obj.close()
    pos_list.reverse()
    for i in range(len(pos_list)):
        print(pos_list[i], end=' ')

path = "C:\\Users\\Joshua\\Desktop\\Joshua's Files\\Australian National University\\3rd year\\Semester 1\\COMP1730- Programming for Scientists\\Labs"
file1 = "cat_picture_1.txt"
file2 = "cat_picture_2.txt"
file3 = "cat_picture_1_binary.txt"
file4 = "cat_picture_2_binary.txt"

def read_img(path,file):
    import os
    import numpy
    import matplotlib.pyplot as plot
    os.chdir(path)
    if open(file,'r').read()[:2] == 'P3':
        file_obj = open(file,'r').read().replace('\n',' ').split()
        data = [int(digit) for digit in file_obj[1:]]
        image = numpy.zeros((data[1], data[0], 3))
        count = 3
        for i in range(len(image)):
            for j in range(len(image[i])):
                for k in range(len(image[i][j])):
                    image[i][j][k] = data[count]/data[2]
                    count += 1
    plot.imshow(image, interpolation='none')
    return plot.show()

