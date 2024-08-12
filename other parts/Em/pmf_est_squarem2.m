function [pmf,alphanalyzer] = pmf_est_squarem2(data_set,alphabet,model_order,epsilon,max_iterations)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[samples,dim]=size(data_set); %getting data_set sizes.
F=model_order; 
lambda=init_lambda(F);
matrices=init_matrices(dim,alphabet,F); %init lambda and matrices.
teta=lm2teta(lambda,matrices,dim,alphabet,F);
alphanalyzer=zeros(2*max_iterations,dim*F+1);
saved_index=0;
%log_likelihood=log_likelihood_calc(lambda,matrices,data_set,samples,dim,alphabet,F); %calc initial log-likelihood
for  i=1:max_iterations  % each iteration check if the new log-likelihood is higher(not equal)
    %log_likelihood=log_likelihood_calc(lambda,matrices,data_set,samples,dim,alphabet,F); %calc initial log-likelihood
    [lambda1, matrices1]=em_step(lambda,matrices,data_set,samples,dim,alphabet,F); %step1
    [lambda2, matrices2]=em_step(lambda1,matrices1,data_set,samples,dim,alphabet,F); %step2
    teta1=lm2teta(lambda1,matrices1,dim,alphabet,F); %teta1
    teta2=lm2teta(lambda2,matrices2,dim,alphabet,F); %teta2
    r=teta1-teta; %r
    v=teta2-teta1-r; %v
    alphadist=alpha_calculator(r,v,dim,alphabet,F); %calculating the alpha vector.
    alphadist=alpha_mod(alphadist,1);
    %alphanalyzer(2*i-1,:)=alpha;
    %alphanalyzer(1,i)=alpha(dim*F+1);
    log_likelihood=log_likelihood_calc(lambda2,matrices2,data_set,samples,dim,alphabet,F); %calc initial log-likelihood
    [alpha_max,saved_index]=maximize_alpha(log_likelihood,alphadist,saved_index,teta,r,v,data_set,samples,dim,alphabet,F);

    tetatag=tetacheck_calc(alpha_max,teta,r,v,dim,alphabet,F);
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


function [lambda]=teta2l(teta,dim,alphabet,F)
     lambda=teta(dim*alphabet*F+1:(dim*alphabet+1)*F);
end

function [matrices]=teta2m(teta,dim,alphabet,F)
     matrices=cell(1,dim);
     for n=1:dim
         %teta((n-1)*dim*F+1:n*dim*F)=tens2mat(matrices{n},[1,2]);
         matrices{1,n}=reshape(teta((n-1)*alphabet*F+1:n*alphabet*F),alphabet,F);
     end
end


function [matrices_pro]=matrices_project(matrices,dim,alphabet,F)
    matrices_pro=cell(1,dim);
    for i=1:dim
        matrices_pro{i} = matrix_projector(matrices{i},alphabet,F);
    end 
end

function [log_likelihood_function]=lgfunction(alpha,index,teta,r,v,data_set,samples,dim,alphabet,F)
    if index==dim*F+1
         alphab=alpha(1:dim*F);
         alphax=@(x)[alphab,x];
     elseif index==1
         alphaa=alpha(2:dim*F+1);
         alphax=@(x)[x,alphaa];
     else
         alphab=alpha(1:index-1);
         alphaa=alpha(index+1:dim*F+1);
         alphax=@(x)[alphab,x,alphaa];
     end
     tetatest=@(x) tetacheck_calc(alphax(x),teta,r,v,dim,alphabet,F);
     lambdatest=@(x)teta2l(tetatest(x),dim,alphabet,F);
     matricestest=@(x)teta2m(tetatest(x),dim,alphabet,F);
     lambdatest=@(x)projector(lambdatest(x),F);
     matricestest=@(x)matrices_project(matricestest(x),dim,alphabet,F);
     log_likelihood_function=@(x) (-1).*log_likelihood_calc(lambdatest(x),matricestest(x),data_set,samples,dim,alphabet,F);
end

function [alpha_max,saved_index]=maximize_alpha(log_likelihood,alphadist,index,teta,r,v,data_set,samples,dim,alphabet,F)
alpha_max=-1.*ones(1,dim*F+1);
for i=1:dim*F+1
    indexl=mod(index+i-1,dim*F+1)+1;
    lg=lgfunction(alpha_max,i,teta,r,v,data_set,samples,dim,alphabet,F);
    if alphadist(indexl)<alpha_max(indexl)
        alpha_max(i)= fminbnd(lg,alphadist(i),alpha_max(i));
    end
    if lg(alpha_max(i))<-log_likelihood
        break;
    end
end
saved_index=indexl;
end
