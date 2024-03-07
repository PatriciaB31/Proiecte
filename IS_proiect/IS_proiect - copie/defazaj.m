t=Balea(:, 1);
u=Balea(:, 2);
y=Balea(:, 3);
plot(t, u, t, y)
%%
i1=379; i2=389; %momentele de timp iesire si intrare
i3=374; i4=384;
dt=t(i1)-t(i3); %perioada de achizitie,intarzierea
T=2*(t(i4)-t(i3)) %2*maxim si minim
wn=2*pi/T
def=(dt*wn*180)/pi %defazaj=90 prima data 72 la primele 

k=mean(y)/mean(u)%factor de proportionalitate 
M=((y(i1)-y(i2))/(u(i3)-u(i4))) %amplificarea semnal
z=k/(2*M)

A=[0 1; -wn^2 -2*z*wn];
B=[0; k*wn^2];
C=[1 0];
D=0;
yc=lsim(A,B,C,D,u,t,[y(1), (y(2)-y(1))/(t(2)-t(1))]);
plot(t, [y, yc])
 
J=norm(y-yc)/sqrt(length(y)) 
empn=norm(y-yc)/norm(y-mean(y))*100 
%%
%perioada de achizitie/esantionare atentie la dimensiuni 
Te=t(2)-t(1)
data_id=iddata(y, u,Te)
data_vd=iddata(y, u,Te)
%%
Hf=tf(k*wn^2,[1 2*z*wn wn^2])
%Hz=c2d(Hf,dt,'zoh')
figure
nyquist(Hf)
%%
%identificarea cu ARX
m_arx = arx(data_id,[2,2,1])
%pem_arx= pem(m_arx)
%validarea statistica
figure ; resid(m_arx,data_vd)
%gradul de suprapunere
figure; compare(m_arx,data_vd)
%functia de transfer
H1=tf(m_arx.B,m_arx.A,Te,'variable','z^-1')


%%
%identificarea cu ARMAX
m_armax = armax(data_id,[2,1,1,1])
%validarea statistica nivel de incredere mai bun 
figure ; resid(m_armax,data_vd)
%ne intereseaza primele 2 esantioane 
%gradul de suprapunere
figure; compare(m_armax,data_vd)

%functia de transfer
H2=tf(m_armax.B,m_armax.A,Te,'variable','z^-1')

%% metoda IV intercorelatie 
nA=2;
nB=1 %zerouri nu avem
nd=1; %interfata A/D
m_iv=iv4(data_id,[nA,nB,nd]);
%validare statistica nA+nB+nF
figure; resid(m_iv,data_vd);
%gradul de suprapunere 
figure; compare(m_iv,data_vd)

Hd_iv=tf(m_iv.B,m_iv.A,dt,'variable','z^-1')
Hc_iv=d2c(Hd_iv)

%% metoda OE intercoreltie 
nF=2;%un pol
nB=1;%nu zero
nd=1;%interfatare
m_oe=oe(data_id,[nB,nF,nd]);
%validare statistica nA+nB+nF
figure; resid(m_oe,data_vd);
%gradul de suprapunere 
figure; compare(m_oe,data_vd)

Hd_oe=tf(m_oe.B,m_oe.F,Te,'variable','z^-1')
Hc_oe=d2c(Hd_oe)