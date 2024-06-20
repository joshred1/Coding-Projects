syms x t
u = t./2+sin(2.*x)./12+cos(x+3.*t)-sin(2.*x+6.*t)./12;
fsurf(x,t,u,[-6,6,-6,6],'EdgeColor','none','LineStyle','none',...
    'MeshDensity',1500,'FaceColor',[0.9,0.2,0.2]); zlim([-10,10]);
material shiny; shading interp; lighting gouraud;
light('Position',[0,-20,20],'Style','local','Color',[0.8,0.8,0]);
light('Position',[-300,100,100],'Style','local','Color',[0,0.8,0.8]);
xlabel('x'); ylabel('t'); zlabel('u(x,t)'); grid off;