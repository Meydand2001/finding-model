function [pmf,alphanalyzer,normanalyzer] = pmf_est_squarem(data_set,alphabet,model_order,epsilon,max_iterations)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[samples,dim]=size(data_set); %getting data_set sizes.
F=model_order; 
lambda=init_lambda(F);
matrices=init_matrices(dim,alphabet,F); %init lambda and matrices.
teta=lm2teta(lambda,matrices,dim,alphabet,F);
%[lambda1, matrices1]=em_step(lambda,matrices,data_set,samples,dim,alphabet,F);
%[lambda2, matrices2]=em_step(lambda1,matrices1,data_set,samples,dim,alphabet,F);
%i=0; dif=1; r=100;
alphanalyzer=zeros(2,max_iterations);
normanalyzer=zeros(2,max_iterations);
%log_likelihood=log_likelihood_calc(lambda,matrices,data_set,samples,dim,alphabet,F); %calc initial log-likelihood
for  i=1:max_iterations  % each iteration check if the new log-likelihood is higher(not equal)
    %log_likelihood=log_likelihood_calc(lambda,matrices,data_set,samples,dim,alphabet,F); %calc initial log-likelihood
    [lambda1, matrices1]=em_step(lambda,matrices,data_set,samples,dim,alphabet,F);%step1
    [lambda2, matrices2]=em_step(lambda1,matrices1,data_set,samples,dim,alphabet,F);%step2
    teta1=lm2teta(lambda1,matrices1,dim,alphabet,F);
    teta2=lm2teta(lambda2,matrices2,dim,alphabet,F);
    r=teta1-teta;
    v=teta2-teta1-r;
    normanalyzer(1,i)=norm(r);
    normanalyzer(2,i)=norm(v);
    alpha = - norm(r)/norm(v);
    alphanalyzer(1,i)=alpha;
    log_likelihood=log_likelihood_calc(lambda2,matrices2,data_set,samples,dim,alphabet,F); %calc initial log-likelihood
    if alpha>-1
        alpha=-1;
    else 
        tetacheck=teta-2.*alpha.*r+(alpha.^2).*v;
        [lambdacheck,matricescheck]=teta2lm(tetacheck,dim,alphabet,F);
        lambdacheck=projector(lambdacheck,F);
        for j=1:dim
            matricescheck{j} = matrix_projector(matricescheck{j},alphabet,F);
        end 
        new_log_likelihood=log_likelihood_calc(lambdacheck,matricescheck,data_set,samples,dim,alphabet,F);
        while new_log_likelihood<log_likelihood
            alpha=(alpha-1)/2;
            tetacheck=teta-2.*alpha.*r+(alpha.^2).*v;
            [lambdacheck,matricescheck]=teta2lm(tetacheck,dim,alphabet,F);
            lambdacheck=projector(lambdacheck,F);
            for j=1:dim
                matricescheck{j} = matrix_projector(matricescheck{j},alphabet,F);
            end 
            new_log_likelihood=log_likelihood_calc(lambdacheck,matricescheck,data_set,samples,dim,alphabet,F);
        end
    end 
    %lambdatag=lambda2;
    %matricestag=matrices2;
    alphanalyzer(2,i)=alpha;
    tetatag=teta-2.*alpha.*r+(alpha.^2).*v;
    tetatag=abs(tetatag);
    [lambdatag,matricestag]=teta2lm(tetatag,dim,alphabet,F);
    lambdatag=projector(lambdatag,F);
    for j=1:dim
        matricestag{j} = matrix_projector(matricestag{j},alphabet,F);
    end 
    tetatag=lm2teta(lambdatag,matricestag,dim,alphabet,F);
    [lambda,matrices]=em_step(lambdatag,matricestag,data_set,samples,dim,alphabet,F); % teta=f(teta') step3
    teta=lm2teta(lambda,matrices,dim,alphabet,F);
    if norm(tetatag-teta)<epsilon
        break;
    end
end
matrix=matrices{1};
for i=1:F
    matrix(:,i)=lambda(i).*matrix(:,i);
end
matrices{1}=matrix;%after getting each lambda and matrix. calculate the the pmf via cpd.
pmf=cpdgen(matrices);
end
