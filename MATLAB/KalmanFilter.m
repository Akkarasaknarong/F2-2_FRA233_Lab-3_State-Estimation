
data = load("E:\FIBO\F2-2\FRA233\Lab3\DamperEstimate\60sec_6Nut.mat");
time = data.out.timer.Data(73:end,:);
dist  = data.out.dist_raw.Data(73:end,:);

time_kalman = [];
dist_kalman = [] ;
timer_loop = 0 ;
dt = 0.001;

Q = Q_R_ratio * [ (dt^4)/4 , (dt^3)/2 ; 
                   (dt^3)/2 ,   dt^2   ];
R = 0.03;

% Q_Tune = 50000 ;
% R = 1000 ;
% Define Variable
x_prev = [0;0];
p_prev = eye(2);

% Define Matrix
F = [1 dt;
     0 1];
H = [1 0];

% Q = Q_Tune * [Q_pos 0;
%               0     Q_vel];

s = size(dist, 1);
upsample_factor = round(1500/16);
for i = 1:s
    for j = 1:upsample_factor
        timer_loop = timer_loop + dt;  
        z = dist(i);

        x_pred = F * x_prev;
        p_pred = (F * p_prev * F') + Q;

        K = (p_pred * H') / (H * p_pred * H' + R);
        x_est = x_pred + K * (z - H * x_pred);
        p_est = (eye(2) - K * H) * p_pred;

        p_prev = p_est;
        x_prev = x_est;

        time_kalman = [time_kalman; timer_loop];
        dist_kalman = [dist_kalman; x_est(1)];
    end
end

kalman_data = [time_kalman dist_kalman];

% figure;
stairs(time, dist);   
grid on;
hold on;
plot(time_kalman, dist_kalman);  
hold off;
legend("Raw 16Hz", "Kalman 1000Hz"); 
xlabel("Time (s)");
ylabel("Distance (m)");
title("Kalman Filter Result");
% xlim([0 8]);
% ylim([13 17]);