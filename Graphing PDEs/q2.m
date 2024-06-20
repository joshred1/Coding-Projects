u = @(x,t) 1./(1+(x+2.5.*t).^2) + 1./(1+(x-2.5.*t).^2) + ...
    (exp(-(x-2.5.*t).^2)-exp(-(x+2.5.*t).^2))./(2*2.5);
fsurf(u,[-20,20,0,10],'EdgeColor','none','LineStyle','none',...
    'MeshDensity',500,'FaceColor',[0.9,0.2,0.2]);
material shiny; shading interp; lighting gouraud;
light('Position',[-50,50,100],'Style','local','Color',[0.8,0.8,0]);
light('Position',[-20,1.5,1],'Style','local','Color',[0,0.8,0.8]);
xlabel('x'); ylabel('t'); zlabel('u(x,t)'); grid off;
hold on
