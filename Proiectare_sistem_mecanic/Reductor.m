%Reductorul
 
%1.numerele de dinti ale rotii dintate:
z1=28;
z2=80;
 
%2.coeficentii de deplasare a profilurilor
x1=0.87;
x2=1.85;
 
%numarul de ordine i:
i=5;
 
%turatie motorului de antrenare:
ni=(55+9*i)*10 ;%[rad/min]
 
%turatia motorului ni este egal cu n1:
n1=ni;
 
%3.modulul:
m=2 ;%[mm]
 
%4.unghiul de angrenare
alfa0=(20*pi)/180;
invalfa0=0.01490;
invalfa=0.033229;
alfa=(23.1833*pi)/180 ;
 
%5.coeficientul de modificare a distanteti dritre axe:
y=((z1+z2)*(cos(alfa0)/cos(alfa)-1))/2;
 
%6.distnata axiala:
a=(m*(z1+z2)*cos(alfa0))/(2*cos(alfa)); %[mm]
 
%7. coeficientul de scuratre a inaltimii dintilor:
psi=x1+x2-y;
 
%8.inlatimea dintilor:
h=m*(2.25-psi); %[mm]

%9.diametrul cercurilor de divizare:
d1=m*z1; %[mm]
r1=d1/2;
d2=m*z2; %[mm]
r2=d2/2;
 
%10.diametrul cercurilor de baza:
db1=m*z1*cos(alfa0); %[mm]
rb1=db1/2;
db2=m*z2*cos(alfa0); %[mm]
rb2=db2/2;


 
%11.diametrul cercurilor de rostogolire:
dw1 = m*z1*cos(alfa0)/cos(alfa); %[mm]
rw1 = dw1/2;
dw2 = m*z2*cos(alfa0)/cos(alfa); %[mm]
rw2 = dw2/2;
 
%12.diametrul cercurilor de cap:
da1 = m*(z1+2+2*x1-2*psi); %[mm]
ra1 = da1/2;
da2 = m*(z2+2+2*x2-2*psi); %[mm]
ra2 = da2/2;
 
%13.diametrul cercurilor de picior:
df1 = m*(z1-2+2*x1-0.5); %[mm]
rf1 = df1/2;
df2 = m*(z2-2+2*x2-0.5); %[mm]
rf2 = df2/2;
 
%14.arcele dintilor pe cercurile de divizare:
s1=pi*m/2+2*m*x1*tan(alfa0); %[mm]
s2=pi*m/2+2*m*x1*tan(alfa0); %[mm]
 
%15.gradul de acoperire:
epsilon=(sqrt(ra2^2 - rb2^2) + sqrt(ra1^2-rb1^2) - a*sin(alfa))/(pi*m*cos(alfa0));
 
%16.corzile constante:
sc1 = m*(pi/2 * cos(alfa0)^2 + x1*sin(2*alfa0)); %[mm]
sc2 = m*(pi/2 * cos(alfa0)^2 + x2*sin(2*alfa0)); %[mm]
 