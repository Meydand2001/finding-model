%profile on;
%iterv=zeros(1,10);

[pmf1,iter]=pmf_est_louis_em_l(incompleted_data_set,5,5,0.001,0.00001,100);
%profile viewer;