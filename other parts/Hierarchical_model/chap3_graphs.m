load 'chap3_sat_res.mat';
load 'chap3_nsat_res.mat';

S=7; Tr=10;
rows=[2000,5000,10000,20000,50000,100000,200000];
for tr = 1:Tr
    kld_accuracy_sat = sum(sat_res, 2);
    kld_accuracy_nsat = sum(nsat_res, 2);
end

loglog(rows,kld_accuracy_sat);
hold on; grid on;
loglog(rows, kld_accuracy_nsat);

