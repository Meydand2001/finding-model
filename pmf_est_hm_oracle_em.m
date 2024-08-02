function [lambda,b_matrices,a_tensors] = pmf_est_hm_oracle_em(data_set,lambda_samples,g_samples,alphabet,g_alphabet,model_order,M,fld)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[samples,dim]=size(data_set); %getting data_set sizes.
F=model_order;
opfld=cell(dim,1);
for n=1:dim
    opfld{n}=setdiff(1:M,fld{n});
end
[lambda, b_matrices, a_tensors]=hm_em_oracle_step(data_set,samples,dim,lambda_samples,g_samples,alphabet,F,g_alphabet,M,fld,opfld);
end