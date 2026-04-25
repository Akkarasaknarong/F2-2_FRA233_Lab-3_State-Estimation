data1 = load("E:\FIBO\F2-2\FRA233\Lab3\Varience\20cm_rec1.mat");
data2 = load("E:\FIBO\F2-2\FRA233\Lab3\Varience\20cm_rec2.mat");
data3 = load("E:\FIBO\F2-2\FRA233\Lab3\Varience\20cm_rec3.mat");

data1 = data1.data{3}.Values.Data;
data2 = data2.data{3}.Values.Data;
data3 = data3.data{3}.Values.Data;

var1 = var(data1);
var2 = var(data2);
var3 = var(data3);

% disp([var1 var2 var3]);