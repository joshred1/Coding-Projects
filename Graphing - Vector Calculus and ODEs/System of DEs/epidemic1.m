function odes1 = epidemic1(t,y)
k1 = 0.8
k2 = 0.7
odes1 = [-k1*y(1)*y(2); 
        -k2*y(2) + k1*y(1)*y(2);
        k2*y(2)] 
end
