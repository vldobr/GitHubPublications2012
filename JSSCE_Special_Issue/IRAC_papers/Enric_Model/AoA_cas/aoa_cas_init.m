% EXAMPLE #1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AoA CAS for F-16
clear,clc

%% Trim condition    
zeq=0;              %[ft]
Veq=502;            %[ft/s]          
alphaeq=0.03691;    %[rad]
thetaeq=0.03691;    %[rad]
delta_eeq=-0.7588;  %[deg]


%% FULL MODEL

% state vector:     x = {V alpha theta q}'
% output vector:    y = {alpha q}'
% input vector:     u = deltae
% State Space:      xdot = Ax+Bu; y = Cx
A   =   [-1.9311e-2   8.8157e+0 -3.2170e+1 -5.7499e-1;
         -2.5389e-4  -1.0189e+0  0.0000e+0  9.0506e-1;
          0.0000e+0   0.0000e+0  0.0000e+0  1.0000e+0;
          2.9465e-12  8.2225e-1  0.0000e+0 -1.0774e+0];
B   =   [ 1.7370e-1;
         -2.1499e-3;
          0.0000e+0;
         -1.7555e-1];
C   =   [0.000000e+0       180/pi  0.000000e+0  0.000000e+0;
         0.000000e+0  0.000000e+0  0.000000e+0       180/pi];
D   =   zeros(2,1);
%
states  =   {'V' '\alpha' '\theta' 'q'};
inputs  =   {'\delta_e'};
outputs =   {'\alpha' 'q'};
%
ss_ac  =   ss(A,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs);
[ac.wn,ac.zeta,ac.poles]    =   damp(ss_ac);
fprintf(1,'F-16 open-loop transfer functions.\n')
tf_ac  =   minreal(zpk(ss_ac))



%% ACTUATOR TF

tau_a   =   1/20.2;     % [s] actuator time constant
%STATE-SPACE
% state vector:     x = {xa}
% output vector:    y = {deltae}
% input vector:     u = ue
% State Space:      xdot = aactx+bactu; y = cactx
aact    =   -1/tau_a;
bact    =   1/tau_a;
cact    =   1;
dact    =   0;
%
states  =   {'xa'};
inputs  =   {'u_e'};
outputs =   {'\delta_e'};
%
ss_act  =   ss(aact,bact,cact,dact,'statename',states,'inputname',inputs,'outputname',outputs);
%TRANSFER FUNCTION
fprintf(1,'Actuator model.\n')
Ga=tf([1/tau_a],[1 1/tau_a])
[numa,dena]=tfdata(Ga,'v');



%% NOISE FILTER TF
tau_f   =   0.1;        % [s] alpha-filter time constant
%STATE-SPACE
% state vector:     x = {xf}
% output vector:    y = {alpha_f}
% input vector:     u = {alpha}
% State Space:      xdot = afilx+bfilu; y = cfilx
afil    =   -1/tau_f;
bfil    =   1/tau_f;
cfil    =   1;
dfil    =   0;
%
states  =   {'xf'};
inputs  =   {'\alpha'};
outputs =   {'\alphaf'};
%
ss_fil  =   ss(afil,bfil,cfil,dfil,'statename',states,'inputname',inputs,'outputname',outputs);
%TRANSFER FUNCTION
fprintf(1,'Noise filter.\n')
Gf=tf([1/tau_f],[1 1/tau_f])
[numf,denf]=tfdata(Gf,'v');


%% PID FCS

% SAS
k_alpha =   -0.08;
k_q     = -0.5;

% CAS
kp = -1.5;
ki = -1.5;


%% CONSTRUCTING REDUCED MODEL

% state vector:     x = {alpha q}'
% output vector:    y = {alpha q}'
% input vector:     u = deltae
% State Space:      xdot = Ax+Bu; y = Cx
Ared   =   [  -1.0189e+0    9.0506e-1;
               8.2225e-1   -1.0774e+0];
Bred   =   [-2.1499e-3;
            -1.7555e-1];
Cred   =   [      180/pi    0.000000e+0;
             0.000000e+0         180/pi];
Dred   =   zeros(2,1);
%
states  =   {'\alpha' 'q'};
inputs  =   {'\delta_e'};
outputs =   {'\alpha' 'q'};
%
ss_acred  =   ss(Ared,Bred,Cred,Dred,'statename',states,'inputname',inputs,'outputname',outputs);
[acred.wn,acred.zeta,acred.poles]    =   damp(ss_acred);
fprintf(1,'F-16 reduced open-loop transfer functions.\n')
tf_acred  =   zpk(ss_acred);


%% SIMULATION

Tsim=15;





