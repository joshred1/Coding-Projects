u = @(x,t) exp(-abs(x+2.*t)).*sqrt(pi)./2;
fsurf(u,[-5,5,0,10],'EdgeColor','none','LineStyle','none','MeshDensity',500);
material shiny; shading interp; lighting gouraud; colormap jet;
xlabel('x'); ylabel('t'); zlabel('u(x,t)'); grid off;