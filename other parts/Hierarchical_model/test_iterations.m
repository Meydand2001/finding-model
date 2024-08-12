load data_set_model3.mat;
Tr=10;
S=7;
data_set=data_set_model{2};
alphabet=5; N=5;
model_order=size(data_set_model{5},1);
g_alphabet=[2,2,2];
M=size(data_set_model{6},1);
array_of_sizes=data_set_model{7}(:,2);
fld=data_set_model{7}(:,3);
max_iterations=1500; epsilon=10^-5;
param_accuracy=zeros(S,Tr,1);
kld_accuracy=zeros(S,Tr,1);
log_likelihood=zeros(S,Tr,max_iterations./10+1);
iter=zeros(S,Tr,max_iterations./10+1);
lambda1=data_set_model{5};
b_matrices1=data_set_model{6};
a_tensors1=data_set_model{7}(:,1);
pmf1=hm2pmf(lambda1,b_matrices1,a_tensors1,model_order,alphabet,M,g_alphabet,N,fld);
rows=[2000,5000,10000,20000,50000,100000,200000];
for s=1:S
    for tr=1:Tr
    %profile on;
    data_set_test=data_set(1:rows(s),:);
    [lambda2,b_matrices2,a_tensors2,iter(s,tr,:),log_likelihood(s,tr,:)] = pmf_est_hm_em(data_set_test,alphabet,g_alphabet,model_order,M,array_of_sizes,fld,epsilon,max_iterations);
    %profile off;
    param_accuracy(s,tr)=param_accuracy_calc(lambda1,b_matrices1,a_tensors1,lambda2,b_matrices2,a_tensors2,M,N);
    pmf2=hm2pmf(lambda2,b_matrices2,a_tensors2,model_order,alphabet,M,g_alphabet,N,fld);
    kld_accuracy(s,tr)=kld_accuracy_calc(pmf1,pmf2,10^-7);
    end
end
%profile viewer;