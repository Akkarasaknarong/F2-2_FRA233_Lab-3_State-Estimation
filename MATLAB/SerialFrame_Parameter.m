clc;clear;

%% Prepare backtest data
data = load("C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab-3_State-Estimation\MATLAB\Part3\Displacement from Equilibrium\replay_2cm_rec1.mat");
time = data.time; % Get Raw time
dist  = data.dist; % Get Raw Distance

%% Math model
% math_model = load("C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab-3_State-Estimation\MATLAB\Part3\Prepare with Mathmodel\model_5Nut_rec1.mat");
% time_model = math_model.data{1}.Values.Time; % Get Raw time
% dist_model  = math_model.data{1}.Values.Data; % Get Raw Distance

%% timeseries for Simulink
% hold on ;
% plot(time_model,dist_model);
stairs(time,dist);
replay_data = timeseries(dist, time);
% model = timeseries(dist_model,time_model);