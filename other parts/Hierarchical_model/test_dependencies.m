load data_set_model.mat;
S=40;
data_set=data_set_model{2};
data_set=data_set(1:50000,:);
alphabet=5; N=5;
model_order=size(data_set_model{5},1);
g_alphabet=[2,2,2];
M=size(data_set_model{6},1);
arrays_of_sizes=cell(5,5);
arrays_of_sizes{1,1}=[2,2]; arrays_of_sizes{2,1}=[2,2]; arrays_of_sizes{3,1}=[2]; arrays_of_sizes{4,1}=[2,2]; arrays_of_sizes{5,1}=[2,2];
arrays_of_sizes{1,2}=[2,2]; arrays_of_sizes{2,2}=[2,2]; arrays_of_sizes{3,2}=[2,2]; arrays_of_sizes{4,2}=[2]; arrays_of_sizes{5,2}=[2];
arrays_of_sizes{1,3}=[2,2,2]; arrays_of_sizes{2,3}=[2]; arrays_of_sizes{3,3}=[2,2,2]; arrays_of_sizes{4,3}=[2,2]; arrays_of_sizes{5,3}=[2,2];
arrays_of_sizes{1,4}=[2]; arrays_of_sizes{2,4}=[2]; arrays_of_sizes{3,4}=[2]; arrays_of_sizes{4,4}=[2]; arrays_of_sizes{5,4}=[2];
arrays_of_sizes{1,5}=[2,2,2]; arrays_of_sizes{2,5}=[2,2,2]; arrays_of_sizes{3,5}=[2,2,2]; arrays_of_sizes{4,5}=[2,2,2]; arrays_of_sizes{5,5}=[2,2,2];
flds=cell(5,5);
flds(:,1)=data_set_model{7}(:,3);
flds{1,2}=[1,2]; flds{2,2}=[1,3]; flds{3,2}=[2,3]; flds{4,2}=[1]; flds{5,2}=[3];
flds{1,3}=[1,2,3]; flds{2,3}=[3]; flds{3,3}=[1,2,3]; flds{4,3}=[2,3]; flds{5,3}=[1,3];
flds{1,4}=[1]; flds{2,4}=[3]; flds{3,4}=[2]; flds{4,4}=[2]; flds{5,4}=[3];
flds{1,5}=[1,2,3]; flds{2,5}=[1,2,3]; flds{3,5}=[1,2,3]; flds{4,5}=[1,2,3]; flds{5,5}=[1,2,3]; 
array_of_sizes=data_set_model{5}(:,2);
max_iterations=1500; epsilon=10^-5;
kld_accuracy=zeros(5,S);
log_likelihood=zeros(5,S,max_iterations./10+1);
iter=zeros(5,S,max_iterations./10+1);
lambda1=data_set_model{3};
b_matrices1=data_set_model{4};
a_tensors1=data_set_model{5}(:,1);
pmf1=hm2pmf(lambda1,b_matrices1,a_tensors1,model_order,alphabet,M,g_alphabet,N,fld);
for c=1:5
    for s=1:S
        [lambda2,b_matrices2,a_tensors2,iter(c,s,:),log_likelihood(c,s,:)] = pmf_est_hm_em(data_set,alphabet,g_alphabet,model_order,M,arrays_of_sizes(:,c),flds(:,c),epsilon,max_iterations);
        %param_accuracy(s)=param_accuracy_calc(lambda1,b_matrices1,a_tensors1,lambda2,b_matrices2,a_tensors2,M,5);
        pmf2=hm2pmf(lambda2,b_matrices2,a_tensors2,model_order,alphabet,M,g_alphabets(c,:),N,fld);
        kld_accuracy(c,s)=kld_accuracy_calc(pmf1,pmf2,10^-7);
    end
end