clc; clear; close all;

%% Load data
base_path = "C:\Users\Akkarasaknarong\Documents\GitHub\F2-2_FRA233_Lab-3_State-Estimation\MATLAB\Part3\Displacement from Equilibrium";

data1 = load(fullfile(base_path, "plot_2cm_rec1.mat"));
data2 = load(fullfile(base_path, "plot_2cm_rec2.mat"));
data3 = load(fullfile(base_path, "plot_2cm_rec3.mat"));

data4 = load(fullfile(base_path, "plot_4cm_rec1.mat"));
data5 = load(fullfile(base_path, "plot_4cm_rec2.mat"));
data6 = load(fullfile(base_path, "plot_4cm_rec3.mat"));

data7 = load(fullfile(base_path, "plot_6cm_rec1.mat"));
data8 = load(fullfile(base_path, "plot_6cm_rec2.mat"));
data9 = load(fullfile(base_path, "plot_6cm_rec3.mat"));

data_all = {data1, data2, data3, ...
            data4, data5, data6, ...
            data7, data8, data9};

case_name = ["2cm_rec1", "2cm_rec2", "2cm_rec3", ...
             "4cm_rec1", "4cm_rec2", "4cm_rec3", ...
             "6cm_rec1", "6cm_rec2", "6cm_rec3"];

save_folder = fullfile(base_path);

if ~exist(save_folder, "dir")
    mkdir(save_folder);
end

%% Index setting
raw_idx = 1;   % Raw Distance
kf_idx  = 2;   % KF Position Estimation

%% Plot setting
raw_color = [0.00 0.45 0.74];   
kf_color  = [0.85 0.33 0.10];  

zoom_range = [1.5 6.5];

for i = 1:length(data_all)

    data = data_all{i};

    t_raw = double(data.data{raw_idx}.Values.Time(:));
    x_raw = double(squeeze(data.data{raw_idx}.Values.Data));

    t_kf = double(data.data{kf_idx}.Values.Time(:));
    x_kf = double(squeeze(data.data{kf_idx}.Values.Data));

    if i <= 3
        % 2 cm
        overview_range = [0 25];
    elseif i <= 6
        % 4 cm
        overview_range = [0 40];
    else
        % 6 cm
        overview_range = [];
    end

    %% ===== 1) Overview Plot =====
    figure("Color", "w");
    hold on;
    grid on;
    box on;

    stairs(t_raw, x_raw, ...
        "Color", raw_color, ...
        "LineWidth", 1.0);

    plot(t_kf, x_kf, ...
        "Color", kf_color, ...
        "LineWidth", 1.6);

    if ~isempty(overview_range)
        xlim(overview_range);
    end

    legend("Raw Distance", ...
        "Kalman Filter Estimation", ...
        "Location", "northeast", ...
        "FontSize", 12);

    xlabel("time (s)");
    ylabel("distance (m)");

    file_name = case_name(i) + "_overview.png";
    file_path = fullfile(save_folder, file_name);
    exportgraphics(gcf, file_path, "Resolution", 300);

    close(gcf);

    %% ===== 2) Zoom Plot =====
    figure("Color", "w");
    hold on;
    grid on;
    box on;

    stairs(t_raw, x_raw, ...
        "Color", raw_color, ...
        "LineWidth", 1.0);

    plot(t_kf, x_kf, ...
        "Color", kf_color, ...
        "LineWidth", 1.6);

    xlim(zoom_range);

    legend("Raw Distance", ...
           "Kalman Filter Estimation", ...
            "Location", "northeast", ...
            "FontSize", 12);

    xlabel("time (s)");
    ylabel("distance (m)");

    file_name = case_name(i) + "_zoom.png";
    file_path = fullfile(save_folder, file_name);
    exportgraphics(gcf, file_path, "Resolution", 300);

    close(gcf);

end