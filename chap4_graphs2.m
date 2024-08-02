load 'chap4_results/kld_accuracy_fld.mat';
load 'chap4_results/mre_fld.mat';

threshold=[0.01,0.025,0.05,0.1,0.25,0.5];

kld_accuracy_fld_avg = sum(kld_accuracy, 1)./20;
mre_fld_avg = sum(mre, 1)./20;

figure;
subplot(1,2,1);
loglog(threshold, kld_accuracy_fld_avg,"-square");
grid on;
title("KLD as a function of the threshold");  xlabel("Threshold"); ylabel("KLD");
xlim([0.01,0.5]);

subplot(1,2,2);
loglog(threshold, mre_fld_avg,"-square");
grid on;
title("MRE as a function of the threshold");  xlabel("Threshold"); ylabel("MRE");
xlim([0.01,0.5])