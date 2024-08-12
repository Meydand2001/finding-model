load 'chap2_hmem_res.mat';
load 'chap2_cpd_res.mat';
load 'chap2_two_step_res.mat';

S=7; Tr=10;
rows=[2000,5000,10000,20000,50000,100000,200000];
for tr = 1:Tr
    kld_accuracy_hmem = sum(hmem_res, 2);
    kld_accuracy_cpd = sum(cpd_res, 2);
    kld_accuracy_two_step = sum(two_step, 2);

end

loglog(rows,kld_accuracy_hmem);
hold on; grid on;
loglog(rows, kld_accuracy_cpd);
loglog(rows, kld_accuracy_two_step);
