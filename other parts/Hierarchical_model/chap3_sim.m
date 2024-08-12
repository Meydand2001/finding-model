%% import the two HM and its data set define all the initial values.
load data_set_model_sat.mat;
Tr=10;
data_set_sat=data_set_model{2};
alphabet=5; N=5;
model_order_sat=size(data_set_model{5},1);
g_alphabet_sat=[2,2,2];
M_sat=size(data_set_model{6},1);
array_of_sizes_sat=data_set_model{7}(:,2);
fld_sat=data_set_model{7}(:,3);
max_iterations=1500; epsilon=10^-5;
lambda_sat=data_set_model{5};
b_matrices_sat=data_set_model{6};
a_tensors_sat=data_set_model{7}(:,1);
pmf_sat=hm2pmf(lambda_sat,b_matrices_sat,a_tensors_sat,model_order_sat,alphabet,M_sat,g_alphabet_sat,N,fld_sat);


load data_set_model_nsat.mat;
data_set_nsat=data_set_model{2};
model_order_nsat=size(data_set_model{5},1);
g_alphabet_nsat=[2,2,2];
M_nsat=size(data_set_model{6},1);
array_of_sizes_nsat=data_set_model{7}(:,2);
fld_nsat=data_set_model{7}(:,3);
lambda_nsat=data_set_model{5};
b_matrices_nsat=data_set_model{6};
a_tensors_nsat=data_set_model{7}(:,1);
pmf_nsat=hm2pmf(lambda_nsat,b_matrices_nsat,a_tensors_nsat,model_order_nsat,alphabet,M_nsat,g_alphabet_nsat,N,fld_nsat);
%% For s in the array for 1:S run HMEM.
S=7;
kld_accuracy_sat=zeros(S,Tr);
kld_accuracy_nsat=zeros(S,Tr);
log_likelihood_sat=zeros(S,Tr,max_iterations./10+1);
log_likelihood_nsat=zeros(S,Tr,max_iterations./10+1);
iter_sat=zeros(S,Tr,max_iterations./10+1);
iter_nsat=zeros(S,Tr,max_iterations./10+1);
rows=[2000,5000,10000,20000,50000,100000,200000];

for s=1:S
    for tr=1:Tr
        data_set_test_sat=data_set(1:rows(s),:);
        [lambda_e_sat,b_matrices_e_sat,a_tensors_e_sat,iter_sat(s,tr,:),log_likelihood_sat(s,tr,:)] = pmf_est_hm_em(data_set_test_sat,alphabet,g_alphabet_sat,model_order_sat,M_sat,array_of_sizes_sat,fld_sat,epsilon,max_iterations);
        pmf_est_sat=hm2pmf(lambda_e_sat,b_matrices_e_sat,a_tensors_e_sat,model_order_sat,alphabet,M_sat,g_alphabet_sat,N,fld_sat);
        kld_accuracy_sat(s,tr)=kld_accuracy_calc(pmf_sat,pmf_est_sat,10^-7);

        data_set_test_nsat=data_set(1:rows(s),:);
        [lambda_e_nsat,b_matrices_e_nsat,a_tensors_e_nsat,iter_nsat(s,tr,:),log_likelihood_nsat(s,tr,:)] = pmf_est_hm_em(data_set_test_nsat,alphabet,g_alphabet_nsat,model_order_nsat,M_nsat,array_of_sizes_nsat,fld_nsat,epsilon,max_iterations);
        pmf_est_nsat=hm2pmf(lambda_e_nsat,b_matrices_e_nsat,a_tensors_e_nsat,model_order_nsat,alphabet,M_nsat,g_alphabet_nsat,N,fld_nsat);
        kld_accuracy_nsat(s,tr)=kld_accuracy_calc(pmf_nsat,pmf_est_nsat,10^-7);
    end
end
% check KLD between the result and real tensor.
% average them.

% Do exactly the Same for the second model.