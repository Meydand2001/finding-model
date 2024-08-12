load data_set_model3.mat;
S=7;
data_set=data_set_model{2};
lambda_samples=data_set_model{3};
g_samples=data_set_model{4};
N=5;
alphabet=5;
model_order=size(data_set_model{5},1);
g_alphabet=[2,2,2];
M=size(data_set_model{6},1);
array_of_sizes=data_set_model{7}(:,2);
fld=data_set_model{7}(:,3);
max_iterations=2000; epsilon=10^-5;
param_accuracy=zeros(S,1);
kld_accuracy=zeros(S,1);
log_likelihood=zeros(S,max_iterations./10+1);
iter=zeros(S,max_iterations./10+1);
lambda1=data_set_model{5};
b_matrices1=data_set_model{6};
a_tensors1=data_set_model{7}(:,1);
pmf1=hm2pmf(lambda1,b_matrices1,a_tensors1,model_order,alphabet,M,g_alphabet,N,fld);
rows=[2000,5000,10000,20000,50000,100000,200000];
for s=1:S
    [lambda2,b_matrices2,a_tensors2] = pmf_est_hm_oracle_em(data_set(1:rows(s),:),lambda_samples(1:rows(s),:),g_samples(1:rows(s),:),alphabet,g_alphabet,model_order,M,fld);
    param_accuracy(s)=param_accuracy_calc(lambda1,b_matrices1,a_tensors1,lambda2,b_matrices2,a_tensors2,M,N);
    pmf2=hm2pmf(lambda2,b_matrices2,a_tensors2,model_order,alphabet,M,g_alphabet,N,fld);
    kld_accuracy(s)=kld_accuracy_calc(pmf1,pmf2,10^-7);
end