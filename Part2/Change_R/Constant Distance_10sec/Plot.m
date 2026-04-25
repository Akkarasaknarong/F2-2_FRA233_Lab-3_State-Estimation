clc;clear;

data1 = load("E:\FIBO\F2-2\FRA233\Lab3\Part2\Change_R\Constant Distance_10sec\10cm_Constant_Distance_rec1.mat");
data2 = load("E:\FIBO\F2-2\FRA233\Lab3\Part2\Change_R\Constant Distance_10sec\10cm_Constant_Distance_rec2.mat");
data3 = load("E:\FIBO\F2-2\FRA233\Lab3\Part2\Change_R\Constant Distance_10sec\10cm_Constant_Distance_rec3.mat");
data4 = load("E:\FIBO\F2-2\FRA233\Lab3\Part2\Change_R\Constant Distance_10sec\15cm_Constant_Distance_rec1.mat");
data5 = load("E:\FIBO\F2-2\FRA233\Lab3\Part2\Change_R\Constant Distance_10sec\15cm_Constant_Distance_rec2.mat");
data6 = load("E:\FIBO\F2-2\FRA233\Lab3\Part2\Change_R\Constant Distance_10sec\15cm_Constant_Distance_rec3.mat");
data7 = load("E:\FIBO\F2-2\FRA233\Lab3\Part2\Change_R\Constant Distance_10sec\20cm_Constant_Distance_rec1.mat");
data8 = load("E:\FIBO\F2-2\FRA233\Lab3\Part2\Change_R\Constant Distance_10sec\20cm_Constant_Distance_rec2.mat");
data9 = load("E:\FIBO\F2-2\FRA233\Lab3\Part2\Change_R\Constant Distance_10sec\20cm_Constant_Distance_rec3.mat");

data_all = {data1,data2,data3,data4,data5,data6,data7,data8,data9} ;
folder_path = "E:\FIBO\F2-2\FRA233\Lab3\Part2\Change_R\Constant Distance_10sec";
set_legend = ["Raw Distance", ...
        "KF (R1 = 1e-01)", ...
        "KF (R2 = 1e-02)", ...
        "KF (R3 = 1e-03)"];

for i = 1 : 9
    data = data_all{i};

    t1 = data.data{5}.Values.Time ;
    x0 = data.data{3}.Values.Data ; % Raw Distance
    x1 = data.data{5}.Values.Data ; % R1 = 1e-01
    x2 = data.data{6}.Values.Data ; % R2 = 1e-02
    x3 = data.data{7}.Values.Data ; % R3 = 1e-03
    
    figure;
    hold("on");
    grid("on");
    plot(t1,x0,Color="black",LineWidth=0.6);
    plot(t1,x1,Color="r",LineWidth=0.7);
    plot(t1,x2,Color="g",LineWidth=0.7);
    plot(t1,x3,Color="b",LineWidth=0.6);
    xlim([0 1.5]);

    legend(set_legend,Location="best");
    xlabel("time (s)");
    ylabel("distance (cm)");

    file_name = "rec" + i + ".png";
    file_path = fullfile(folder_path,file_name);
    exportgraphics(gcf, file_path, "Resolution", 300);
    close(gcf);
end




