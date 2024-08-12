%% import the two HM and its data set define all the initial values.
load data_set_model.mat;
Tr=10;
data_set=data_set_model{2};
alphabet=5; N=5;
model_order=size(data_set_model{5},1);
g_alphabet=[2,2,2];
M=size(data_set_model{6},1);
array_of_sizes=data_set_model{7}(:,2);
fld=data_set_model{7}(:,3);
max_iterations=1500; epsilon=10^-5;
lambda=data_set_model{5};
b_matrices=data_set_model{6};
a_tensors=data_set_model{7}(:,1);
pmf=hm2pmf(lambda,b_matrices,a_tensors,model_order,alphabet,M,g_alphabet,N,fld);



%% For s in the array for 1:S run HMEM.
S=7;
kld_accuracy_hmem=zeros(S,Tr);
kld_accuracy_two_step=zeros(S,Tr);
kld_accuracy_cpd=zeros(s,Tr);
log_likelihood_hmem=zeros(S,Tr,max_iterations./10+1);
log_likelihood_two_step=zeros(S,Tr,max_iterations./10+1);
log_likelihood_cpd=zeros(S,Tr,max_iterations./10+1);
iter_hmem=zeros(S,Tr,max_iterations./10+1);
iter_two_step=zeros(S,Tr,max_iterations./10+1);
iter_cpd=zeros(S,Tr,max_iterations./10+1);
rows=[2000,5000,10000,20000,50000,100000,200000];

for s=1:S
    for tr=1:Tr
        data_set_test=data_set(1:rows(s),:);
        [lambda_hmem,b_matrices_hmem,a_tensors_hmem,iter_hmem(s,tr,:),log_likelihood_hmem(s,tr,:)] = pmf_est_hm_em(data_set_test,alphabet,g_alphabet,model_order,M,array_of_sizes,fld,epsilon,max_iterations);
        pmf_hmem=hm2pmf(lambda_hmem,b_matrices_hmem,a_tensors_hmem,model_order,alphabet,M,g_alphabet,N,fld);
        kld_accuracy_hmem(s,tr)=kld_accuracy_calc(pmf,pmf_hmem,10^-7);

        [b_matrix_two_step,a_tensors_two_step,iter_two_step(s,tr,:),log_likelihood_two_step(s,tr,:)] = pmf_est_shm_em(data_set_test,alphabet,g_alphabet,model_order,M,array_of_sizes,fld,epsilon,max_iterations);
        pmf_two_step=shm2pmf(b_matrix_two_step,a_tensors_hmem,alphabet,M,g_alphabet,N,fld);
        kld_accuracy_two_step(s,tr)=kld_accuracy_calc(pmf,pmf_two_step,10^-7);

        [lambda_cpd,b_matrices_cpd,iter_cpd(s,tr,:),log_likelihood_cpd(s,tr,:)] = pmf_est_hm_em(data_set_test,alphabet,prod(g_alphabet),epsilon,max_iterations);
        pmf_cpd= cpd2pmf(lambda_cpd,b_matrices_cpd,alphabet,g_alphabet,N);
        kld_accuracy_cpd(s,tr)=kld_accuracy_calc(pmf,pmf_cpd,10^-7);

    end
end
% check KLD between the result and real tensor.
% average them.

% Do exactly the Same for the second model.
