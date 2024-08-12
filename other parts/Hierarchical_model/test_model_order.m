load data_set_model3.mat;
S=50;
data_set=data_set_model{2};
data_set=data_set(1:50000,:);
alphabet=5; N=5;
model_order=size(data_set_model{5},1);
g_alphabet=[2,2,2];
M=size(data_set_model{6},1);
array_of_sizes=data_set_model{7}(:,2);
fld=data_set_model{7}(:,3);
max_iterations=1500; epsilon=10^-5;
%param_accuracy=zeros(S,1);
kld_accuracy=zeros(3,S);
log_likelihood=zeros(3,S,max_iterations./10+1);
iter=zeros(3,S,max_iterations./10+1);
lambda1=data_set_model{5};
b_matrices1=data_set_model{6};
a_tensors1=data_set_model{7}(:,1);
pmf1=hm2pmf(lambda1,b_matrices1,a_tensors1,model_order,alphabet,M,g_alphabet,N,fld);
for f=(model_order-1):(model_order+1)
    for s=1:S
        [lambda2,b_matrices2,a_tensors2,iter(f,s,:),log_likelihood(f,s,:)] = pmf_est_hm_em(data_set,alphabet,g_alphabet,f,M,array_of_sizes,fld,epsilon,max_iterations);
        %param_accuracy(s)=param_accuracy_calc(lambda1,b_matrices1,a_tensors1,lambda2,b_matrices2,a_tensors2,M,5);
        pmf2=hm2pmf(lambda2,b_matrices2,a_tensors2,f,alphabet,M,g_alphabet,N,fld);
        kld_accuracy(f,s)=kld_accuracy_calc(pmf1,pmf2,10^-7);
    end
end