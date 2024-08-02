load 'chap4_results/struct_sim/kld_accuracy.mat';
load 'chap4_results/struct_sim/kld_accuracy_over.mat';
load 'chap4_results/struct_sim/kld_accuracy_under.mat';
load 'chap4_results/struct_sim/mre.mat';
load 'chap4_results/struct_sim/mre_over.mat';
load 'chap4_results/struct_sim/mre_under.mat';

rows=[2000,5000,10000,20000,50000,100000];


kld_accuracy_avg = sum(kld_accuracy, 2)./20;
kld_accuracy_over_avg = sum(kld_accuracy_over, 2)./20;
kld_accuracy_under_avg = sum(kld_accuracy_under, 2)./20;

mre_avg = sum(mre, 2)./20;
mre_over_avg = sum(mre_over, 2)./20;
mre_under_avg = sum(mre_under, 2)./20;

figure;
subplot(1,2,1);
loglog(rows, kld_accuracy_avg,"-square");
hold on; grid on;
loglog(rows,kld_accuracy_over_avg,"-o");
loglog(rows, kld_accuracy_under_avg,"-diamond");
title("KLD Comparison");  xlabel("T"); ylabel("KLD"); legend(["Correct Structure","Overparameterized","Underparameterized"]);
xlim([2000,100000]);

subplot(1,2,2);
loglog(rows, mre_avg,"-square");
hold on; grid on;
loglog(rows,mre_over_avg,"-o");
loglog(rows, mre_under_avg,"-diamond");
title("MRE Comparison");  xlabel("T"); ylabel("MRE"); legend(["Correct Structure","Overparameterized","Underparameterized"]);
xlim([2000,100000]);