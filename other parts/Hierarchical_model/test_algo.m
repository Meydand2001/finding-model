load data_set_model_test5.mat;
S=1;
data_set=data_set_model{2};
data_set=data_set(1:200000,:);
N=5;
alphabet=5;
model_order=size(data_set_model{5},1);
g_alphabet=[2,3];
M=size(data_set_model{6},1);
array_of_sizes=data_set_model{7}(:,2);
fld=data_set_model{7}(:,3);
max_iterations=2000; epsilon=5*10^-6;
param_accuracy=zeros(S,1);
kld_accuracy=zeros(S,1);
log_likelihood=zeros(S,max_iterations./10+1);
iter=zeros(S,max_iterations./10+1);
lambda1=data_set_model{5};
b_matrices1=data_set_model{6};
a_tensors1=data_set_model{7}(:,1);
pmf1=hm2pmf(lambda1,b_matrices1,a_tensors1,model_order,alphabet,M,g_alphabet,N,fld);
for s=1:S
    profile on;
    [lambda2,b_matrices2,a_tensors2,iter(s,:),log_likelihood(s,:)] = pmf_est_hm_em(data_set,alphabet,g_alphabet,model_order,M,array_of_sizes,fld,epsilon,max_iterations);
    profile off;
    param_accuracy(s)=param_accuracy_calc(lambda1,b_matrices1,a_tensors1,lambda2,b_matrices2,a_tensors2,M,N);
    pmf2=hm2pmf(lambda2,b_matrices2,a_tensors2,model_order,alphabet,M,g_alphabet,N,fld);
    kld_accuracy(s)=kld_accuracy_calc(pmf1,pmf2,10^-7);
end
profile viewer;