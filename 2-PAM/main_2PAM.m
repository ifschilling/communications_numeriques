%% Ian Fischer Schilling; François Vanlerberghe
clear; % Efface  les  variables  de l’environnement  de travail
close all;
clc;

%% Initialisation des paramètres
fe = 10000; %1/Te
Te = 1/fe;
Ds = 1000; %1kSymboles/s
Ts = 0.001;
Ns = 5000;
% g(t)
Fse = Ts*fe;
Nfft = 512;
A = 1;

%% Emetteur
Sb = randi([0, 1], [1, Ns]);
Ss = 2*A*Sb(1:Ns) -A; 
up_sampling = fe/Ds;
Ss_us = zeros(1, Ns*up_sampling);
Ss_us(1:up_sampling:length(Ss_us)) = Ss;
%g(t)
g(1:Fse)=1;
Sl = conv(Ss_us, g);
Sl = Sl(1:Ns*up_sampling);

%% Canal
h = 1;
w = zeros(1, Ns*up_sampling);
yl = conv(Sl, h);
yl = yl(1:Ns*up_sampling) + w;

%% Récepteur
%ga(t)
ga(1:Fse)=1;
rlt = conv(yl, ga);
rlt = rlt(1:Ns*up_sampling)/Fse;
rln = rlt(10:up_sampling:length(rlt));
An=(rln>0)-(rln<0);
Sf=(An+A)/(2*A);

%% Affichage des résultats
t = 0:Te:500*Ts-Te;
figure, grid
plot(t,Ss)
title("Ss")
xlabel("Temps")
ylabel("Ss")
figure, grid
plot(t,Sl(1:10:length(Sl)))
title("Sl")
xlabel("Temps")
ylabel("Sl")
figure, grid
plot(t,rln)
title("rl(n)")
xlabel("Temps")
ylabel("rl(n)")