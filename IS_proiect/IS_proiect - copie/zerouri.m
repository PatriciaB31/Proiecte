t=Balea(:, 1);
u=Balea(:, 2);
y=Balea(:, 4);
plot(t, u, t, y)

%%
i1=334; i2=322;
i3=332; i4=320;

k=mean(y)/mean(u)
Mr=((y(i1)-y(i2))/(u(i3)-u(i4)))/k %amplificarea de rezonanta(maxima)
z=sqrt((Mr-sqrt(Mr^2-1)))/(2/Mr) 
Tr=2*(t(i3)-t(i4))
wr=2*pi/Tr
wn=wr/sqrt(1-2*z^2)

dt=t(i1)-t(i3) 
phr=(t(i3)-t(i1))*wr %faza la rezonanta

Tz=tan(phr+atan(sqrt(1-2*z^2)/z))/wr

num=k*wn^2*[Tz 1]
den=[1 2*z*wn wn^2]

Hc=tf(num, den)
%% 
a=y(i1)-Tz*(y(i1)-y(i1-1))/dt
b=y(i2)-Tz*(y(i2)-y(i2-1))/dt
c=u(i3)-u(i4)


Mrc=((y(i1)-y(i2))/(u(i3)-u(i4))-Tz*(y(2)-y(1))/dt)/k
zc=sqrt(Mrc-sqrt(Mrc^2-1))/(2/Mrc)
wnc=wr/sqrt(1-2*zc^2)
Tzc=tan(phr+atan(sqrt(1-2*zc^2)/zc))/wr
numc=[k*wnc^2*Tzc k*wnc^2]
denc=[1 2*zc*wnc wnc^2]
%% forma canonica de observare 

[Ac, Bc, Cc, D]=tf2ss(numc, denc)
A_FCOc=[-2*zc*wnc 1; -wnc^2 0];
B_FCOc=[Tzc*k*wnc^2; k*wnc^2];
C_FCOc=[1 0];
D=0;

ycc=lsim(A_FCOc,B_FCOc,C_FCOc,D,u,t,[y(1), (y(2)-y(1))/dt+2*zc*wnc*y(1)])
plot(t, [y ycc])

J=norm(y-ycc)/sqrt(length(y)) 
empn=norm(y-ycc)/norm(y-mean(y))*100

Te=t(2)-t(1)
data_id=iddata(y, u,Te)
data_vd=iddata(y, u,Te)
%% identificarea cu ARX
m_arx = arx(data_id,[2,2,1])
%validarea statistica
figure ; resid(m_arx,data_vd)
%gradul de suprapunere
figure; compare(m_arx,data_vd)
%functia de transfer
H1=tf(m_arx.B,m_arx.A,Te,'variable','z^-1')
Hz=d2c(H1,'zoh')
%% identificarea cu ARMAX
m_armax = armax(data_id,[2,2,2,1])
%validarea statistica nivel de incredere mai bun 
figure ; resid(m_armax,data_vd)
%ne intereseaza primele 2 esantioane 
%gradul de suprapunere
figure; compare(m_armax,data_vd)
%functia de transfer
H2=tf(m_armax.B,m_armax.A,Te,'variable','z^-1')
%% metoda IV intercorelatie 
nA=2;
nB=2 %zerouri=1
nd=1; %interfata A/D
m_iv=iv4(data_id,[nA,nB,nd]);
%validare statistica nA+nB+nF
figure; resid(m_iv,data_vd);
%gradul de suprapunere 
figure; compare(m_iv,data_vd)
Hd_iv=tf(m_iv.B,m_iv.A,Te,'variable','z^-1')
Hc_iv=d2c(Hd_iv)

%% metoda OE intercoreltie 
nF=2;%un pol
nB=2;%un zero
nd=1;%interfatare
m_oe=oe(data_id,[nB,nF,nd]);
%validare statistica nA+nB+nF
figure; resid(m_oe,data_vd);
%gradul de suprapunere 
figure; compare(m_oe,data_vd)
Hd_oe=tf(m_oe.B,m_oe.F,Te,'variable','z^-1')
Hc_oe=d2c(Hd_oe)
