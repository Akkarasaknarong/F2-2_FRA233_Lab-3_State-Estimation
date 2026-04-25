clear;clc;

Timer_raw = 0 ;
Distance_raw = 0;

%% Mass Spring Damper Parameter
k = 29.839 ; % [N/m]
b = 0.08;
m = 0.039 * 5 ;  % [kg]
g = 9.81 ;
F = 0 ;

t_start = 0.979;
t_end = 100 ;
final_pos = 0.097 ;

%% Estimate Parameter
% Q Select
Q = 1 ;
% Load Data
data = load("E:\FIBO\F2-2\FRA233\Lab3\DamperEstimate\US_16Hz_KF_1000Hz.mat");
t_raw= double(data.data{Q}.Values.Time);
x_raw = double(squeeze(data.data{Q}.Values.Data));

% Clipping Time
t_mark = (t_raw > t_start) & (t_raw < t_end) ;

% Prepare Estimate Data / Shift Time
t_est = t_raw(t_mark) ;
t_est = t_est - t_est(1) ; % Shift Time

x_est = x_raw(t_mark) ;    % Shift X
x_est = x_est - x_est(end);        % Convert cm to m
x_inti = x_est(1) ;

%% Example Plot Graph 
plot(t_est,x_est,LineWidth=1.5);
title("Raw Data");
legend("Line");
grid("on");
raw_data = [t_est x_est];

% open("B_MSD_Estimate.slx");