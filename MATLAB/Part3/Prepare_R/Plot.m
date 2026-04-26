clc; clear;

data1 = load("C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab-3_State-Estimation\MATLAB\Part3\Prepare_R\rec1.mat");
data2 = load("C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab-3_State-Estimation\MATLAB\Part3\Prepare_R\rec2.mat");
data3 = load("C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab-3_State-Estimation\MATLAB\Part3\Prepare_R\rec3.mat");

data_all = {data1, data2, data3};

folder_path = "C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab-3_State-Estimation\MATLAB\Part3\Prepare_R";

q_label = ["R1 = 100", ...
           "R2 = 1", ...
           "R3 = 0.01"];

raw_color    = [0.00 0.45 0.74];  
kalman_color = [0.85 0.33 0.10];  

raw_idx = 1;
q_idx = [2 3 4];

for rec = 1:3

    data = data_all{rec};

    t_raw = data.data{raw_idx}.Values.Time;
    x_raw = data.data{raw_idx}.Values.Data;

    for q = 1:3

        t_kf = data.data{q_idx(q)}.Values.Time;
        x_kf = data.data{q_idx(q)}.Values.Data;

        figure;
        hold on;
        grid on;

        stairs(t_raw, x_raw, Color=raw_color, LineWidth=2.0);
        stairs(t_kf, x_kf, Color=kalman_color, LineWidth=2.0);
        xlim([10 13]);
        

        legend("Raw Distance", ...
               "KF (" + q_label(q) + ")", ...
               Location="southeast" ,FontSize=16);
    
        xlabel("time (s)");
        ylabel("distance (m)");
        
    
        file_name = "rec" + rec + "_Q" + q + ".png";
        file_path = fullfile(folder_path, file_name);

        exportgraphics(gcf, file_path, "Resolution", 300);
        close(gcf);

    end
end