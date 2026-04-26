x_est_kalman = [];
t_est_kalman = [];
count_timer_loop = 0;

% Mass spring damper parameter
k = 29.839 ; % [N/m]
b = 0.028;
g = 9.81 ;
F = 0 ;

%% Only Change this part------------------------ 
Nut = 5 ;
m = (0.039*Nut) + (0.145);  % mass (Nut + Box)

dist_end = 9.74138 ;

% Load Raw data 
data = load("C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab-3_State-Estimation\MATLAB\Part1\DamperEstimate\5Nut_rec1.mat");
time = data.data{2}.Values.Data(1:end,:); % Get Raw time
dist  = data.data{1}.Values.Data(1:end,:); % Get Raw Distance
dist  = dist - dist_end ; % Get Raw Distance (Displacement from equilibrium)

% Cut time 
idx_start = find(time > 57.4205, 1, "first");
time = time(idx_start:end);
dist = dist(idx_start:end);

% Frequency setting
sensor_dt = 0.06 ;
kalman_dt = 0.001 ;
sample_size = length(time);       % Sample of data [scalar]
upsample_size = round(sensor_dt / kalman_dt); % Sample when Up 16Hz to 1000Hz [scalar]

% Kalman Filter Parameter
F = [1                  kalman_dt;
     -k/m*kalman_dt     1-(b/m*kalman_dt)];
H = [1 0];
Q = [ 1e-03 , 0       ; 
      0        , 1e-01   ];
R = 0.185;
%% ----------------------------------------------

%% Kalman Filter Process
% Define Variable
x_prev = [0;
          0];
p_prev = eye(2);


for i = 1:sample_size
    for j = 1:upsample_size  

        % Get raw  measuremented
        z = dist(i); 
        
        % Prediction state
        x_pred = F * x_prev;
        p_pred = (F * p_prev * F') + Q;
        
        % Correction state
        K = (p_pred * H') / (H * p_pred * H' + R);
        x_est = x_pred + K * (z - H * x_pred);
        p_est = (eye(2) - K * H) * p_pred;
        
        % store correction data
        x_est_kalman = [x_est_kalman;x_est(1)];
        t_est_kalman = [t_est_kalman;count_timer_loop];

        % store previous state
        p_prev = p_est;
        x_prev = x_est;
        count_timer_loop = count_timer_loop + kalman_dt ;
    end
end

%% Plot graph kalman filter 
time = time - time(1); % Get Raw time
kalman_data = [t_est_kalman x_est_kalman];

figure ;
hold on ;
stairs (time,dist);
plot(t_est_kalman, x_est_kalman);   
legend("Distance raw" , "Distance Kalman");
grid on;