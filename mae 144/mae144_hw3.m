clear
close all

% 1
a0=0.1; b0=0.1;
G = tf(0.1,[1 0.1],'InputDelay',6);
figure(1)
bode(G)

% 2
K=0.6;
H=feedback(G,K);
figure(2)
bode(H)
[gm1,pm1,wcg1,wcp1] = margin(H);

% 4a
a=0.6;b=0.5;c=0.125;
ku=3.2; tu=1/0.3;
kp=a*ku; ti=b*tu; td=c*tu;
tf=tf([1 1/td 1/(ti*td)],[1 0]);
DPID = kp*td*tf;
figure(3)
approx = pade(G,1);
sys = feedback(approx*DPID,1);
bode(approx*DPID)
[gm2,pm2,wcg2,wcp2] = margin(sys);

% 4b
figure(4)
step(approx*DPID)