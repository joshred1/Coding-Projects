function odes3 = epidemic3(t,y)
k1 = 1
k2 = 0.7
odes3 = [-k1*y(1)*y(2); 
        -k2*y(2) + k1*y(1)*y(2);
        k2*y(2)] 
end
