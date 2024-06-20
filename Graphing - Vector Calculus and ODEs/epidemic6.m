function odes5 = epidemic4(t,y)
k1 = 10
k2 = 0.7
odes5 = [-k1*y(1)*y(2); 
        -k2*y(2) + k1*y(1)*y(2);
        k2*y(2)] 
end