z1=28;
z2=80;
%numar ordine 
i=5;
%turatia motor 
ni=1000;
n1=ni;
n2=n1*(z1/z2);
%cursa piston 
smax=130+i;

phi=0:0.01:2*pi;
omega=1099.525;
lambda=0.2341;
l1=27.8316;
l2=107.1683;

sB=@(phi)l1*(1/lambda-1/4*lambda+cos(phi)+1/4*lambda*cos(2*phi));
vB=@(phi)(-l1*omega*(sin(phi)+1/2*lambda*sin(2*phi)));
aB=@(phi)(-l1*omega^2*(cos(phi)+lambda*cos(2*phi)));



fplot(sB, [0, 6]) 
grid ; xlabel('phi'); ylabel('spatiul');
figure

fplot(vB, [0, 6])
grid ;xlabel('phi'); ylabel('viteza');

figure
fplot(aB, [0 6])
grid;  xlabel('phi'); ylabel('acceleratia');