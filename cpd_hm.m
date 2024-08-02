load data_set_model4.mat;
data_set=data_set_model{2};
data_set=data_set(1:50000,:);
N=5;
alphabet=5; S=50 ;
model_order=size(data_set_model{5},1);
g_alphabet=[2,2,2];
M=size(data_set_model{6},1);
array_of_sizes=data_set_model{7}(:,2);
fld=data_set_model{7}(:,3);
max_iterations=1500; epsilon=10^-5;
%param_accuracy=zeros(S,1);
lambda1=data_set_model{5};
b_matrices1=data_set_model{6};
a_tensors1=data_set_model{7}(:,1);
pmf1=hm2pmf(lambda1,b_matrices1,a_tensors1,model_order,alphabet,M,g_alphabet,N,fld);
%{
kld_accuracy1=zeros(2,S);
for s=1:S
    [lambda2,b_matrices2,a_tensors2,iter,log_likelihood] = pmf_est_hm_em(data_set,alphabet,g_alphabet,model_order,M,array_of_sizes,fld,epsilon,max_iterations);
    [pmf_cpd1,lambda_cpd1,a_matrices1,iter2] = pmf_est_Em(data_set,alphabet,8,epsilon,max_iterations);
    pmf2=hm2pmf(lambda2,b_matrices2,a_tensors2,model_order,alphabet,M,g_alphabet,N,fld);
    kld_accuracy1(1,s)=kld_accuracy_calc(pmf1,pmf2,10^-7);
    kld_accuracy1(2,s)=kld_accuracy_calc(pmf1,pmf_cpd1,10^-7);
end
%}
load data_set_cpd.mat;
data_set=data_set_model{2};
data_set=data_set(1:50000,:);
cpd_lambda1=data_set_model{3};
cpd_matrices1=data_set_model{4};
matrix=cpd_matrices1{1};
matrix=cpd_lambda1'.*matrix;
%for i=1:8
%    matrix(:,i)=lambda1(i).*matrix(:,i);
%end
cpd_matrices1{1}=matrix;%after getting each lambda and matrix. calculate the the pmf via cpd.
pmf=cpdgen(cpd_matrices1);
kld_accuracy2=zeros(2,S);
for s=1:S
    [lambda3,b_matrices3,a_tensors3,iter3,log_likelihood2] = pmf_est_hm_em(data_set,alphabet,g_alphabet,model_order,M,array_of_sizes,fld,epsilon,max_iterations);
    [pmf_cpd2,lambda_cpd2,a_matrices2,iter4] = pmf_est_Em(data_set,alphabet,8,epsilon,max_iterations);
    pmf3=hm2pmf(lambda3,b_matrices3,a_tensors3,model_order,alphabet,M,g_alphabet,N,fld);
    kld_accuracy2(1,s)=kld_accuracy_calc(pmf,pmf3,10^-7);
    kld_accuracy2(2,s)=kld_accuracy_calc(pmf,pmf_cpd2,10^-7);
end