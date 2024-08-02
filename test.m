load data_set_model_chap2.mat;
Tr=50;
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

S=1;
kld_accuracy_hmem=zeros(S,Tr);
kld_accuracy_two_step=zeros(S,Tr);
kld_accuracy_cpd=zeros(S,Tr);
log_likelihood_hmem=zeros(S,Tr,max_iterations./10+1);
log_likelihood_two_step=zeros(S,Tr,max_iterations./10+1);
log_likelihood_cpd=zeros(S,Tr,max_iterations./10+1);
iter_hmem=zeros(S,Tr,max_iterations./10+1);
iter_two_step=zeros(S,Tr,max_iterations./10+1);
iter_cpd=zeros(S,Tr);
rows=10000;
iteration_hmem=zeros(S,Tr);
iteration_two_step=zeros(S,Tr);
iteration_cpd=zeros(S,Tr);

time_hmem=zeros(S,Tr);
time_cpd=zeros(S,Tr);
time_two_step=zeros(S,Tr);
profile on;
for s=1:S
    for tr=1:Tr
        data_set_test=data_set(1:rows(s),:);
        [pmf_cpd,lambda_cpd,b_matrices_cpd,iteration_cpd(s,tr),time_cpd(s,tr)] = pmf_est_Em(data_set_test,alphabet,prod(g_alphabet),epsilon,max_iterations);
    end
end
profile off
profile viewer;