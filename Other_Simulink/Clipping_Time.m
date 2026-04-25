clc ; clear; 

% Load file
data = load("E:\FIBO\F2-2\FRA233\Lab3\DamperEstimate\Data_Test.mat");
% t = data.data.time ;
% x = data.data.distance_cm;

% Clip Time
tar_start = 0.225 ;
tar_end = 5 ;
tar_idx = (t >= tar_start) & (t <= tar_end);

t_cut = t(tar_idx) ; 
x_cut = x(tar_idx); 

t_cut = t_cut - t_cut(1); 

% Plot
plot(t_cut,x_cut,LineWidth= 1.5);
grid("on");
% xlim([0,100]);

save("TEST.mat","t_cut","x_cut");
