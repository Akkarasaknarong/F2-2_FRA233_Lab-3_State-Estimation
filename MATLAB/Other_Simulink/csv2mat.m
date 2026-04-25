clear;clc;

data = readtable("DamperEstimate/Ultrasonic_5Nut_rec1.csv");
t = data{:,1};
x = data{:,2} / 100;

save("Ultrasonic_5Nut_rec1.mat","data");
