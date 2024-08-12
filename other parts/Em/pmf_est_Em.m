function [pmf,iter] = pmf_est_Em(data_set,alphabet,model_order,epsilon,max_iterations)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[samples,dim]=size(data_set); %getting data_set sizes.
F=model_order; 
lambda=init_lambda(F);
matrices=init_matrices(dim,alphabet,F); %init lambda and matrices.
teta=lm2teta(lambda,matrices,dim,alphabet,F);
%log_likelihood=log_likelihood_calc(lambda,matrices,data_set,samples,dim,alphabet,F); %calc initial log-likelihood
for i=1:max_iterations % each iteration check if the new log-likelihood is higher(not equal)
    [lambda, matrices]=em_step(lambda,matrices,data_set,samples,dim,alphabet,F); % teta=f(teta)
    %projection of both lambda and matrices to the constraint space.
    %lambda=projector(lambda,F);
    %for j=1:dim
     %   matrices{j}=matrix_projector(matrices{j},alphabet,F);
    %end
    %new_log_likelihood=log_likelihood_calc(lambda,matrices,data_set,samples,dim,alphabet,F);
    %dif=new_log_likelihood-log_likelihood; %calculate the difference between the 2 log-likelihoods.
    %log_likelihood=new_log_likelihood;
    tetatag=lm2teta(lambda,matrices,dim,alphabet,F);
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