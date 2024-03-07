t=Balea(:, 1);
u=Balea(:, 2);
y=Balea(:, 3);
plot(t, u, t, y)
xlabel('timp[s]')
ylabel('amplitudine[V]')
%%
i1=358; i2=347;
i3=353; i4=342;

%factor de proportionalitate
k=mean(y)/mean(u)
Mr=((y(i1)-y(i2))/(u(i3)-u(i4)))/k %amplificarea de rezonanta(maxima)modulul functiei de tranfer 
%z=sqrt((Mr-sqrt(Mr^2-1)))/(2/Mr) 
z=sqrt((Mr-sqrt(Mr^2-1))/2/Mr)

Tr=2*(t(i3)-t(i4))
wr=2*pi/Tr
wn=wr/sqrt(1-2*z^2)

A=[0 1; -wn^2 -2*z*wn];
B=[0; k*wn^2];
C=[1 0];
D=0;
yc=lsim(A,B,C,D,u,t,[y(1), 0]);%0=derivata lui x1=y


plot(t, [y, yc])
xlabel('timp[s]')
ylabel('amplitudine[V]')
 
J=norm(y-yc)/sqrt(length(y)) 
empn=norm(y-yc)/norm(y-mean(y))*100 
%%
Hf=tf(k*wn^2,[1 2*z*wn wn^2])
%% perioada de achizitie/esantionare atentie la dimensiuni 
Te=t(2)-t(1)
data_id=iddata(y, u,Te)
data_vd=iddata(y, u,Te)
%% identificarea cu ARX
m_arx = arx(data_id,[2,1,1])
%validarea statistica
figure ; resid(m_arx,data_vd)
%gradul de suprapunere
figure; compare(m_arx,data_vd)
%functia de transfer
H1=tf(m_arx.B,m_arx.A,Te,'variable','z^-1')
Hz=d2c(H1,'zoh')
%% identificarea cu ARMAX
m_armax = armax(data_id,[2,1,2,1])
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
m_iv=iv4(data_id,[nA,nB,nd])
%validare statistica nA+nB+nF
figure; resid(m_iv,data_vd);
%gradul de suprapunere 
figure; compare(m_iv,data_vd)
Hd_iv=tf(m_iv.B,m_iv.A,Te,'variable','z^-1')
Hc_iv=d2c(Hd_iv)

%% metoda OE intercoreltie 
nF=2;%un pol
nB=1;%nu zero
nd=1;%interfatare
m_oe=oe(data_id,[nB,nF,nd])
%validare statistica nA+nB+nF
figure; resid(m_oe,data_vd);
%gradul de suprapunere 
figure; compare(m_oe,data_vd)
Hd_oe=tf(m_oe.B,m_oe.F,Te,'variable','z^-1')
Hc_oe=d2c(Hd_oe)
%%
figure; compare(data_vd,m_arx,m_armax,m_iv,m_oe)