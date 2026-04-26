clc;clear;

%% Prepare backtest data
data = load("C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab-3_State-Estimation\MATLAB\Part1\DamperEstimate\5Nut_rec3.mat");
time = data.data{2}.Values.Data(1:end,:); % Get Raw time
dist  = data.data{1}.Values.Data(1:end,:); % Get Raw Distance

dist = dist / 100; % Distance cm to m

% Cut time 

idx_start = find(time > 81.4799, 1, "first"); % step 1
time = time(idx_start:end);
dist = dist(idx_start:end);
time = time - time(1);

dist_end = 0.0974138 ; % Step 2
dist  = dist - dist_end ; % Get Raw Distance (Displacement from equilibrium)

stairs(time,dist)
% ------------------------------------------- 

% timeseries for Simulink
replay_data = timeseries(dist, time);