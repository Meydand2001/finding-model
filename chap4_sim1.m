load data_set_model_chap42.mat;
Tr=20;
data_set=data_set_model{2};
alphabet=5; N=5;
model_order=size(data_set_model{5},1);
g_alphabet=[2,2,2];
M=size(data_set_model{6},1);
array_of_sizes=data_set_model{7}(:,2);
fld=data_set_model{7}(:,3);
max_iterations=1000; epsilon=10^-3;
lambda=data_set_model{5};
b_matrices=data_set_model{6};
a_tensors=data_set_model{7}(:,1);
pmf=hm2pmf(lambda,b_matrices,a_tensors,model_order,alphabet,M,g_alphabet,N,fld);

fld_over=cell(N,1);
fld_over{1}=[1 2 3]; fld_over{2}=[1 2 3]; fld_over{3}=[1 2]; fld_over{4}=[1 2 3]; fld_over{5}=[2 3];
array_of_sizes_over=cell(N,1);
array_of_sizes_over{1}=[2 2 2]; array_of_sizes_over{2}=[2 2 2]; array_of_sizes_over{3}=[2 2];
array_of_sizes_over{4}=[2 2 2]; array_of_sizes_over{5}=[2 2];

fld_under=cell(N,1);
fld_under{1}=[1 3]; fld_under{2}=[1 2]; fld_under{3}=[1 2]; fld_under{4}=[2 3]; fld_under{5}=[3];
array_of_sizes_under=cell(N,1);
array_of_sizes_under{1}=[2 2]; array_of_sizes_under{2}=[2 2]; array_of_sizes_under{3}=[2 2];
array_of_sizes_under{4}=[2 2]; array_of_sizes_under{5}=[2];

%% For s in the array for 1:S run HMEM.
S=6;
kld_accuracy=zeros(S,Tr);
kld_accuracy_over=zeros(S,Tr);
kld_accuracy_under=zeros(S,Tr);
mre=zeros(S,Tr);
mre_over=zeros(S,Tr);
mre_under=zeros(S,Tr);
param_accuracy=zeros(S,Tr);
param_accuracy_over=zeros(S,Tr);
param_accuracy_under=zeros(S,Tr);
log_likelihood=zeros(S,Tr,max_iterations./10+1);
log_likelihood_over=zeros(S,Tr,max_iterations./10+1);
log_likelihood_under=zeros(S,Tr,max_iterations./10+1);

iter=zeros(S,Tr,max_iterations./10+1);
iter_over=zeros(S,Tr,max_iterations./10+1);
iter_under=zeros(S,Tr,max_iterations./10+1);
%rows=[2000,5000,10000,20000,50000,100000];
rows = [2000,5000,10000,20000,50000,100000];

for s=1:S
    for tr=1:Tr
        data_set_test=data_set(1:rows(s),:);
        [lambda_r,b_matrices_r,a_tensors_r,iter(s,tr,:),log_likelihood(s,tr,:)] = pmf_est_hm_em(data_set_test,alphabet,g_alphabet,model_order,M,array_of_sizes,fld,epsilon,max_iterations);
        pmf_r=hm2pmf(lambda_r,b_matrices_r,a_tensors_r,model_order,alphabet,M,g_alphabet,N,fld);
        kld_accuracy(s,tr)=kld_accuracy_calc(pmf,pmf_r,10^-7);
        mre(s,tr) = mre_accuracy_calc(pmf,pmf_r);

        [lambda_over,b_matrices_over,a_tensors_over,iter_over(s,tr,:),log_likelihood_over(s,tr,:)] = pmf_est_hm_em(data_set_test,alphabet,g_alphabet,model_order,M,array_of_sizes_over,fld_over,epsilon,max_iterations);
        pmf_over=hm2pmf(lambda_over,b_matrices_over,a_tensors_over,model_order,alphabet,M,g_alphabet,N,fld_over);
        kld_accuracy_over(s,tr)=kld_accuracy_calc(pmf,pmf_over,10^-7);
        mre_over(s,tr) = mre_accuracy_calc(pmf,pmf_over);

        [lambda_under,b_matrices_under,a_tensors_under,iter_under(s,tr,:),log_likelihood_under(s,tr,:)] = pmf_est_hm_em(data_set_test,alphabet,g_alphabet,model_order,M,array_of_sizes_under,fld_under,epsilon,max_iterations);
        pmf_under=hm2pmf(lambda_under,b_matrices_under,a_tensors_under,model_order,alphabet,M,g_alphabet,N,fld_under);
        kld_accuracy_under(s,tr)=kld_accuracy_calc(pmf,pmf_under,10^-7);
        mre_under(s,tr) = mre_accuracy_calc(pmf,pmf_under);

    end
end