%% intervalul de urcare
i=5;
h=7+0.5*i;
phi_urcare=66+i;
phi_repaus_superior=60;
phi_repaus_inferior=80;
phi_coborare=360-phi_urcare-phi_repaus_superior-phi_repaus_inferior;
alfa=45;

faza=0:1:phi_urcare;
s_1=h*(faza/phi_urcare - 1/(2*pi)*sin(2*pi/phi_urcare*faza));
figure,plot(faza, s_1);
title('Spatiul ca functie de faza in intervalul de urcare');
xlabel('ϕ'); ylabel('s(ϕ)'); grid;

v_redusa_1=h/phi_urcare*(1-cos(2*pi/phi_urcare*faza));
figure, plot(faza, v_redusa_1); 
title('Viteza ca functie de faza in intervalul de urcare');
xlabel('ϕ'); ylabel('v(ϕ)'); grid;

a_redusa_1=(2*pi*h)/(phi_urcare^2)*sin(2*pi/phi_urcare*faza);
figure, plot(faza, a_redusa_1);%axis([18 53 -0.015 0.015]);
title('Acceleratia ca functie de faza in intervalul de urcare');
xlabel('ϕ'); ylabel('a(ϕ)'); grid;
%% intervalul de coborare

faza=phi_coborare:-1:0;
s_2=h*(faza/phi_coborare - 1/(2*pi)*sin(2*pi/phi_coborare*faza));
figure, plot(faza, -s_2);
title('Spatiul ca functie de faza in intervalul de coborare');
xlabel('ϕ'); ylabel('s(ϕ)'); grid;

v_redusa_2=h/phi_coborare*(1-cos(2*pi/phi_coborare*faza));
figure, plot(faza, -v_redusa_2);
title('Viteza ca functie de faza in intervalul de coborare');
xlabel('ϕ'); ylabel('v(ϕ)'); grid;

a_redusa_2=(2*pi*h)/(phi_coborare^2)*sin(2*pi/phi_coborare*faza);
figure, plot(faza, a_redusa_2); 
title('Acceleratia ca functie de faza in intervalul de coborare');
xlabel('ϕ'); ylabel('a(ϕ)'); grid;
%% POZITIE


phi=0:phi_urcare; %interval de urcare
s_urcare=h*(phi/phi_urcare - 1/(2*pi)*sin(2*pi/phi_urcare*phi));
figure, plot(phi,s_urcare), grid; title('Variatia cursei tachetului'); hold on;
phi=phi_urcare:phi_coborare; %interval repaus
s=ones(size(phi))*h;
plot(phi,s); hold on;
phi=phi_coborare:-1:0; %interval coborare
s_coborare=h*(phi/phi_coborare - 1/(2*pi)*sin(2*pi/phi_coborare*phi));
plot(2*phi_coborare-phi, s_coborare); hold on
phi=296:0.01:360;
s=ones(size(phi))*0;
plot(phi,s)

% VITEZA
phi=0:phi_urcare; %interval de urcare
v_redusa_urcare=h/phi_urcare*(1-cos(2*pi/phi_urcare*phi));
figure, plot(phi, v_redusa_urcare), grid; title('Variatia vitezei'); hold on;
phi=phi_urcare:phi_coborare; %interval repaus
s=ones(size(phi))*0;
plot(phi, s); hold on;
phi=phi_coborare:-1:0; %interval coborare
v_redusa_coborare=h/phi_coborare*(1-cos(2*pi/phi_coborare*phi));
plot(2*phi_coborare-phi, -v_redusa_coborare); hold on
phi=297:0.01:360;
s=ones(size(phi))*0;
plot(phi,s)
% ACCELERATIA
phi=0:phi_urcare; %interval de urcare
a_redusa_urcare =(2*pi*h)/(phi_urcare^2)*sin(2*pi/phi_urcare*phi);
figure, plot(phi, a_redusa_urcare), grid; title('Variatia acceleratiei'), hold on
%line=143:0.001:144; %socuri
%plot(line, -0.00301*(line==144)), hold on
phi=phi_urcare:phi_coborare; %interval repaus
s=ones(size(phi))*0;
plot(phi, s); hold on
phi=phi_coborare:-1:0; %interval coborare
a_redusa_coborare=(2*pi*h)/(phi_coborare^2)*sin(2*pi/phi_coborare*phi);
plot(2*phi_coborare-phi, a_redusa_coborare); hold on
phi=298:0.01:360;
s=ones(size(phi))*0;
plot(phi,s)