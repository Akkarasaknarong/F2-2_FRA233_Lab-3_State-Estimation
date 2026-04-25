clear; clc;
data = load("E:\FIBO\F2-2\FRA233\Lab3\DamperEstimate\60sec_6Nut.mat");

%% Prepare Estimate Data
time_all = data.out.timer.Data(:);
dist_all = data.out.dist_raw.Data(:) / 100;

% x_inti = -0.067068961740112;
x_inti = -0.0874;
x_final = 0.0837931;

% Clipping Time
time_est = time_all(75:1000) - 0.18;
dist_est = dist_all(75:1000) - x_final;

%% Parameter
k = 29.839 ; % [N/m]
b = 0.1;
m = (0.039*6) + (0.145);  % [kg]
g = 9.81 ;
F = 0 ;

%% Plot Graph
stairs(time_est,dist_est);
grid("on");