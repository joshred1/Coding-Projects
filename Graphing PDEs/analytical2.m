syms u(x,t)
u(x,t) = piecewise(x<t^2, 1, t^2<=x & x<1, (1-x)/(1-t^2), x>=1, 0)
fsurf(u,[-2.5,2.5,0,5],'EdgeColor','none','LineStyle','none','MeshDensity',50,'FaceColor',[0.9,0.2,0.2]);
material shiny; shading interp; lighting gouraud;
xlabel('x'); ylabel('t'); zlabel('u(x,t)'); grid off;
