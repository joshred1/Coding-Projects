syms x t
u = exp((1-exp(2.*t))./6).*(2.*sin(x-(t.^3)./9)+4.*cos(x-(t.^3)./9));
fsurf(x,t,u,[-6,8,-10,8],'EdgeColor','none','LineStyle','none',...
    'MeshDensity',2000,'FaceColor',[0.9,0.2,0.2]); zlim([-10,10]);
material shiny; shading interp; lighting gouraud;
light('Position',[-4,8,12],'Style','local','Color',[0.8,0.8,0]);
light('Position',[150,200,40],'Style','local','Color',[0,0.8,0.8]);
light('Position',[-10,-100,20],'Style','local','Color',[0,0.8,0.8]);
xlabel('x'); ylabel('t'); zlabel('u(x,t)'); grid off;

