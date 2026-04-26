clc;clear;

data1 = load("E:\FIBO\F2-2\FRA233\Lab3\Part2\Change_Q\Specific Change Distance_15sec\rec1.mat");
data2 = load("E:\FIBO\F2-2\FRA233\Lab3\Part2\Change_Q\Specific Change Distance_15sec\rec2.mat");
data3 = load("E:\FIBO\F2-2\FRA233\Lab3\Part2\Change_Q\Specific Change Distance_15sec\rec3.mat");
data_all = {data1,data2,data3} ;
folder_path = "E:\FIBO\F2-2\FRA233\Lab3\Part2\Change_Q\Specific Change Distance_15sec";
set_legend = ["Raw Distance", ...
        "KF (Q1 = 1e-03)", ...
        "KF (Q2 = 1e-04)", ...
        "KF (Q3 = 1e-05)"];

for i = 1 : 3
    data = data_all{i};

    t1 = data.data{5}.Values.Time ;
    x0 = data.data{3}.Values.Data / 100 ; % Raw Distance
    x1 = data.data{5}.Values.Data / 100 ; % R1 = 1e-01
    x2 = data.data{6}.Values.Data / 100 ; % R2 = 1e-02
    x3 = data.data{7}.Values.Data / 100 ; % R3 = 1e-03
    
    figure;
    hold("on");
    grid("on");
    plot(t1,x0,Color="black",LineWidth=0.6);
    plot(t1,x1,Color="r",LineWidth=0.7);
    plot(t1,x2,Color="g",LineWidth=0.7);
    plot(t1,x3,Color="b",LineWidth=0.6);

    legend(set_legend,Location="best");
    xlabel("time (s)");
    ylabel("distance (m)");

    file_name = "rec" + i + ".png";
    file_path = fullfile(folder_path,file_name);
    exportgraphics(gcf, file_path, "Resolution", 300);
    close(gcf);
end




