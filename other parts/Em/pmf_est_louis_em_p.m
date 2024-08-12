function [pmf,iter,lkhessian1,qhessian1,qdersquared1,lkdermult1] = pmf_est_louis_em_p(data_set,alphabet,model_order,epsilon,max_iterations)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[samples,dim]=size(data_set); %getting data_set sizes.
F=model_order;
n=samples;

lkhessian1=zeros(F*dim*(alphabet-1)+F-1,F*dim*(alphabet-1)+F-1,10);qhessian1=zeros(F*dim*(alphabet-1)+F-1,F*dim*(alphabet-1)+F-1,10);
qdersquared1=zeros(F*dim*(alphabet-1)+F-1,F*dim*(alphabet-1)+F-1,10);lkdermult1=zeros(F*dim*(alphabet-1)+F-1,F*dim*(alphabet-1)+F-1,10);
lambda=init_lambda(F);
matrices=init_matrices(dim,alphabet,F); %init lambda and matrices.
for i=1:max_iterations % each iteration check if the new log-likelihood is higher(not equal)
    teta=lm2teta(lambda,matrices,dim,alphabet,F)
    teta=teta+10^-10;
    %size(teta)
    tetatag=teta2param(teta,dim,alphabet,F);
    
    %size(tetatag);
    [lambda, matrices, qhessian, qdersquared, lkdermult]=em_step3(lambda,matrices,data_set,samples,dim,alphabet,F); % teta=f(teta)
    tetaem=lm2teta(lambda,matrices,dim,alphabet,F)
    tetatagem=teta2param(tetaem,dim,alphabet,F);
    lkhessian=1./n.*qdersquared-1./n^2.*lkdermult; %empirical fisher information and estimator for the hessian of the lk.
    tetaitertag=sqrt(tetatag)+((lkhessian+eye(104)./(10^5))^-1)*qhessian*(sqrt(tetatagem)-sqrt(tetatag))./n.^2;
    tetaitertag=tetaitertag.^2;

    lkdermult1(:,:,i)=lkdermult;
    lkhessian1(:,:,i)=lkhessian;
    qdersquared1(:,:,i)=qdersquared;
    qhessian1(:,:,i)=qhessian;

    tetaiter=param2teta(tetaitertag,dim,alphabet,F)
    [lambdaiter,matricesiter]=teta2lm(tetaiter,dim,alphabet,F);
    lambdaiter=projector(lambdaiter,F);
    for j=1:dim
        matricesiter{j} = matrix_projector(matricesiter{j},alphabet,F);
    end
    tetaiter=lm2teta(lambdaiter,matricesiter,dim,alphabet,F)
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


function [param]=teta2param(teta,dim,alphabet,F) % make sure teta is a coloumn vector.
a_values=teta(1:F*dim*alphabet);
a_values=reshape(a_values,[alphabet F*dim]);
param_a_values=a_values(1:alphabet-1,:);
param_a_values=reshape(param_a_values,[F*dim*(alphabet-1) 1]);
lam_values=teta(F*dim*alphabet+1:end);
param_lam_values=lam_values(1:F-1);
param=[param_a_values;param_lam_values];
end

function [teta]=param2teta(param,dim,alphabet,F) % make sure teta is a coloumn vector.
param_a_values=param(1:F*dim*(alphabet-1));
param_a_values=reshape(param_a_values,[alphabet-1 F*dim]);
last_a_values=1-sum(param_a_values);
size(last_a_values)
size(param_a_values)
a_values=[param_a_values;last_a_values];
a_values=reshape(a_values,[F*dim*alphabet 1]);
param_lm_values=param(F*dim*(alphabet-1)+1:end);
last_lam_value=1-sum(param_lm_values);
lam_values=[param_lm_values;last_lam_value];
teta=[a_values;lam_values];
end