function [lambda,b_matrices,a_tensors,iter,log_likelihood,iteration] = pmf_est_hm_em(data_set,alphabet,g_alphabet,model_order,M,array_of_sizes,fld,epsilon,max_iterations)
%PMF_EST_HM_EM Summary of this function goes here
%   Detailed explanation goes here
[samples,dim]=size(data_set); %getting data_set sizes.
F=model_order;
I=alphabet;
lambda=init_vector(F); %initializing lambda,b_matrices and a_tensors.
b_matrices=init_matrices(M,g_alphabet,F);
a_tensors=init_tensors(dim,I,array_of_sizes);
teta=md2teta(lambda,b_matrices,M,a_tensors,dim);
opfld=cell(dim,1);
for n=1:dim
    opfld{n}=setdiff(1:M,fld{n});
end
tensor_sizes=cell(dim,1);
for n=1:dim
   array=array_of_sizes{n};
   full_sizes=ones(1,M);
   full_sizes(fld{n})=array;
   tensor_sizes{n}=full_sizes;
end
log_likelihood=zeros(1,max_iterations/10+1);
iter=zeros(1,max_iterations/10+1);
sam=1;
for i=1:max_iterations
    if mod(i,10)==1
        log_likelihood(sam)=log_likelihood_calc_hm(lambda,b_matrices,a_tensors,data_set,samples,dim,F,M,g_alphabet,tensor_sizes);
        iter(sam)=i-1;
        sam=sam+1;
    end
    [lambda, b_matrices, a_tensors]=hm_em_step(lambda,b_matrices,a_tensors,data_set,samples,dim,alphabet,F,g_alphabet,M,array_of_sizes,fld,opfld,tensor_sizes);
    tetatag=md2teta(lambda,b_matrices,M,a_tensors,dim);
    %norm(tetatag-teta)
    if norm(tetatag-teta)<epsilon
        break;
    end
    teta=tetatag;
end
log_likelihood(sam)=log_likelihood_calc_hm(lambda,b_matrices,a_tensors,data_set,samples,dim,F,M,g_alphabet,tensor_sizes);
iter(sam)=i;
iteration=i;
end
