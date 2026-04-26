clear; clc;

% %% Only Change This Part --------------------------------------------------
% data = load("E:\FIBO\F2-2\FRA233\Lab3\Part1\DamperEstimate\5Nut_rec2.mat");
% 
% % Prepare Estimate Data
% time_all = data.data{2}.Values.Data ;
% dist_all = data.data{1}.Values.Data / 100;
% 
Nut = 5 ;
% x_inti = 0.0803448;
% x_final = 0.0974138 ;
% t_inti = time_all(1)  ;
% 
% % Clipping Time
% time_est = time_all(1:700) - t_inti  - 1.38001;
% dist_est = dist_all(1:700) - x_final;
% 
% % -------------------------------------------------------------------------

%% Parameter
m = (0.039*Nut) + (0.145);  % [kg]
k = 28.37 ; % [N/m]
b = 0.02990;
g = 9.81 ;
F = 0 ;

%% Plot Graph
% stairs(time_est,dist_est);
% grid("on");