load 'chap3_results/param_accuracy_sat.mat';
load 'chap3_results/param_accuracy_nsat.mat';

S=6; Tr=20;
rows=[2000,5000,10000,20000,50000,100000];

param_accuracy_sat_avg = sum(param_accuracy_sat, 2)./20;
param_accuracy_nsat_avg = sum(param_accuracy_nsat, 2)./20;

figure;
loglog(rows, param_accuracy_sat_avg,"-square");
hold on; grid on;
loglog(rows,param_accuracy_nsat_avg,"-o");
title("Parameter Estimation Accuracy(MRE)");  xlabel("T"); ylabel("MRE"); legend(["Satisfied Conditions","Unsatisfied Conditions"])
xlim([2000,100000]);

