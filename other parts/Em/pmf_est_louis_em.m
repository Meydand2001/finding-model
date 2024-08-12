function [pmf,iter,lkhessian1,qhessian1,qdersquared1,lkdermult1] = pmf_est_louis_em(data_set,alphabet,model_order,epsilon,max_iterations)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[samples,dim]=size(data_set); %getting data_set sizes.
F=model_order;
n=samples;
lambda=init_lambda(F);
matrices=init_matrices(dim,alphabet,F); %init lambda and matrices.
for i=1:max_iterations % each iteration check if the new log-likelihood is higher(not equal)
    teta=lm2teta(lambda,matrices,dim,alphabet,F);
    [lambda, matrices, qhessian, qdersquared, lkdermult]=em_step2(lambda,matrices,data_set,samples,dim,alphabet,F); % teta=f(teta)
    tetaem=lm2teta(lambda,matrices,dim,alphabet,F);
    lkhessian=1./n.*qdersquared-1./n^2.*lkdermult; %empirical fisher information and estimator for the hessian of the lk.
    tetaiter=teta+((lkhessian)^-1)*qhessian*(tetaem-teta);
    if i==1
        qhessian1=qhessian;
        lkhessian1=lkhessian;
        qdersquared1=qdersquared;
        lkdermult1=lkdermult;
    end
    [lambdaiter,matricesiter]=teta2lm(tetaiter,dim,alphabet,F);
    lambdaiter=projector(lambdaiter,F);
    for j=1:dim
        matricesiter{j} = matrix_projector(matricesiter{j},alphabet,F);
    end
    tetaiter=lm2teta(lambdaiter,matricesiter,dim,alphabet,F);
    if norm(tetaiter-teta)<epsilon
        break;
    end
    lambda=lambdaiter;
    matrices=matricesiter;
end
iter=i;
matrix=matrices{1};
for i=1:F
    matrix(:,i)=lambda(i).*matrix(:,i);
end
matrices{1}=matrix;%after getting each lambda and matrix. calculate the the pmf via cpd.
pmf=cpdgen(matrices);
end