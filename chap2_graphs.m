load 'chap2_results/kld_accuracy_cpd.mat';
load 'chap2_results/kld_accuracy_hmem.mat';
load 'chap2_results/kld_accuracy_two_step.mat';
load 'chap2_results/mre_cpd.mat';
load 'chap2_results/mre_hmem.mat';
load 'chap2_results/mre_two_step.mat';

 
rows=[2000,5000,10000,20000,50000,100000];


kld_accuracy_hmem_avg = sum(kld_accuracy_hmem, 2)./20;
kld_accuracy_cpd_avg = sum(kld_accuracy_cpd, 2)./20;
kld_accuracy_two_step_avg = sum(kld_accuracy_two_step, 2)./20;

mre_hmem_avg = sum(mre_hmem, 2)./20;
mre_cpd_avg = sum(mre_cpd, 2)./20;
mre_two_step_avg = sum(mre_two_step, 2)./20;

figure;
subplot(1,2,1);
loglog(rows, kld_accuracy_cpd_avg,"-square");
hold on; grid on;
loglog(rows,kld_accuracy_hmem_avg,"-o");
loglog(rows, kld_accuracy_two_step_avg,"-diamond");
title("KLD Comparison");  xlabel("T"); ylabel("KLD"); legend(["CPD","HMEM","2LM"])
xlim([2000,100000]);

subplot(1,2,2);
loglog(rows, mre_cpd_avg,"-square");
hold on; grid on;
loglog(rows,mre_hmem_avg,"-o");
loglog(rows, mre_two_step_avg,"-diamond");
title("MRE Comparison");  xlabel("T"); ylabel("MRE"); legend(["CPD","HMEM","2LM"])
xlim([2000,100000]);

