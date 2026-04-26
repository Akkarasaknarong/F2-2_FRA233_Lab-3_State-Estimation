clc; clear;

data1 = load("C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab-3_State-Estimation\MATLAB\Part3\Prepare with Mathmodel\Prepare_rec1.mat");
data2 = load("C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab-3_State-Estimation\MATLAB\Part3\Prepare with Mathmodel\Prepare_rec2.mat");
data3 = load("C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab-3_State-Estimation\MATLAB\Part3\Prepare with Mathmodel\Prepare_rec3.mat");

data_all = {data1, data2, data3};

folder_path = "C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab-3_State-Estimation\MATLAB\Part3\Prepare with Mathmodel";

if ~exist(folder_path, "dir")
    mkdir(folder_path);
end

kf_idx    = 3;  
model_idx = 1;   

kf_color    = [0.00 0.45 0.74];  
model_color = [0.85 0.33 0.10];  

for rec = 1:3

    data = data_all{rec};

    t_kf = data.data{kf_idx}.Values.Time;
    x_kf = data.data{kf_idx}.Values.Data;

    t_model = data.data{model_idx}.Values.Time;
    x_model = data.data{model_idx}.Values.Data;

    %% ===== Figure 1: Overall Response =====
    figure;
    hold on;
    grid on;

    plot(t_kf, x_kf, ...
        Color=kf_color, ...
        LineWidth=1.2);

    plot(t_model, x_model, ...
        Color=model_color, ...
        LineWidth=1.2);

    legend("Kalman Filter Response", ...
           "Mathematical Model Response", ...
           Location="best");

    xlabel("time (s)");
    ylabel("distance (m)");
  
    file_name = "rec" + rec + "_overview.png";
    file_path = fullfile(folder_path, file_name);
    exportgraphics(gcf, file_path, "Resolution", 300);

    close(gcf);


    %% ===== Figure 2: Zoomed Response 10-15 s =====
    figure;
    hold on;
    grid on;

    plot(t_kf, x_kf, ...
        Color=kf_color, ...
        LineWidth=1.2);

    plot(t_model, x_model, ...
        Color=model_color, ...
        LineWidth=1.2);

    xlim([1.5 6.5]);

    legend("Kalman Filter Response", ...
           "Mathematical Model Response", ...
           Location="best");

    xlabel("time (s)");
    ylabel("distance (m)");

    file_name = "rec" + rec + "_zoom_10_15s.png";
    file_path = fullfile(folder_path, file_name);
    exportgraphics(gcf, file_path, "Resolution", 300);

    close(gcf);

end