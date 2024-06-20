def interpolate(x, y, x_test):
    '''
    Approximates the function value of test value via linear 
    interpolation of a set of sample points. Assumes that the test 
    value is within the range of x-coordinates. Sequence of 
    x-coordinates must be in ascending order and order of sequence 
    of y-coordinates must match the corresponding x values.

    :param x: sequence of x-coordinates
    :param y: sequence of y-coordinates
    :param x_test: x-coordinate of desired function value
    :return: y-coordinate corresponding to x_test
    '''
    #first ensure assumptions of order and length are held and that test value is within range:
    assert min(x) <= x_test <= max(x), "test value is out of range"
    assert sorted(x) == list(x), "coordinates aren't ordered" 
    assert len(x) == len(y), "sequence of coordinates is incomplete"
    #check to see if test value is already included in our x value sequence:
    for i in range(len(x)):
        if x_test == x[i]:
            return y[i]
    #if test value is not already in our x sequence, we compute the values for linear interpolation:
    x_above = min(value for value in x if value > x_test)
    x_below = max(value for value in x if value < x_test)
    y_above = y[x.index(x_above)]
    y_below = y[x.index(x_below)]
    #substitute these values into the linear equation and then return the solution for f(x_test):
    a = (y_above - y_below)/(x_above - x_below)
    b = y_below - a*x_below
    return a*x_test + b




