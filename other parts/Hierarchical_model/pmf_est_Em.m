function [pmf,lambda,matrices,iter] = pmf_est_Em(data_set,alphabet,model_order,epsilon,max_iterations)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[samples,dim]=size(data_set); %getting data_set sizes.
F=model_order; 
lambda=init_lambda(F);
matrices=init_matrices(dim,alphabet*ones(1,dim),F); %init lambda and matrices.
teta=lm2teta(lambda,matrices,dim);
%log_likelihood=log_likelihood_calc(lambda,matrices,data_set,samples,dim,alphabet,F); %calc initial log-likelihood
for i=1:max_iterations % each iteration check if the new log-likelihood is higher(not equal)
    [lambda, matrices]=em_step(lambda,matrices,data_set,samples,dim,alphabet,F); % teta=f(teta)
    tetatag=lm2teta(lambda,matrices,dim);
    if norm(tetatag-teta)<epsilon
        break;
    end
    teta=tetatag;
end
iter=i;
matrix=matrices{1};
for i=1:F
    matrix(:,i)=lambda(i).*matrix(:,i);
end
matrices{1}=matrix;%after getting each lambda and matrix. calculate the the pmf via cpd.
pmf=cpdgen(matrices);
end