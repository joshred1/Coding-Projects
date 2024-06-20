function odes2 = epidemic2(t,y)
k1 = 0.9
k2 = 0.7
odes2 = [-k1*y(1)*y(2); 
        -k2*y(2) + k1*y(1)*y(2);
        k2*y(2)] 
end
