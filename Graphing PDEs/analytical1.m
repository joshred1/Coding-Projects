f = @(x,t) tan(t + 1/x + sqrt((t+1/x)^2-2))/(t^3)
fsurf(f,'MeshDensity',500,'EdgeColor','none','LineStyle','none');
material shiny; shading interp; lighting gouraud;
xlabel('x'); ylabel('t'); zlabel('u(x,t)'); grid off;)
