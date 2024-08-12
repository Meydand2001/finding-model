function [pmf,iter] = pmf_est_louis_em_l(data_set,alphabet,model_order,epsilon1,epsilon2,max_iterations)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[samples,dim]=size(data_set); %getting data_set sizes.
F=model_order;
n=samples;
lambda=init_lambda(F);
matrices=init_matrices(dim,alphabet,F); %init lambda and matrices.
lagmult=ones(F*dim+1,1);
teta=lm2teta(lambda,matrices,dim,alphabet,F);
%alpha=2*10^-5.*(10^(-1/10).*(1:max_iterations));
d=1;
for i=1:max_iterations % each iteration check if the new log-likelihood is higher(not equal)
    if d>=epsilon1
         %teta=lm2teta(lambda,matrices,dim,alphabet,F);
         [lambda, matrices]=em_step(lambda,matrices,data_set,samples,dim,alphabet,F);
         tetaiter=lm2teta(lambda,matrices,dim,alphabet,F);
         d=norm(tetaiter-teta);
         teta=tetaiter;
    else
        i
        teta=teta+10^-12;
        [lambda,matrices]=teta2lm(teta,dim,alphabet,F);
        teta=sqrt(teta);
        %tetalag=[teta;lagmult];
        [lambda, matrices, qhessian, qdersquared, lkdermult]=em_step_4(lambda,matrices,data_set,samples,dim,alphabet,F); % teta=f(teta)
        tetaem=lm2teta(lambda,matrices,dim,alphabet,F);
        tetaem=sqrt(tetaem);
        %tetaemlag=[tetaem;lagmult];
        %{
        lagblock=-2*lagblockgen(teta,dim,alphabet,F);
        lhessian=-2*lhessiangen(lagmult,dim,alphabet,F);
        qhessianb=qhessianb+lhessian;
        qhessian=[qhessianb,lagblock;lagblock.',zeros(F*dim+1)];
        lkhessianb=1./n.*qdersquared-1./n^2.*lkdermult; %empirical fisher information and estimator for the hessian of the lk.
        lkhessianb=lkhessianb+lhessian;
        lkhessian=[lkhessianb,lagblock;lagblock.',zeros(F*dim+1)];
        tetaiterlag=tetalag+((lkhessian)^-1)*qhessian*(tetaemlag-tetalag);
        %}
        lagblock=-2*lagblockgen(teta,dim,alphabet,F);
        lhessian=-2*lhessiangen(lagmult,dim,alphabet,F);
        qhessian=qhessian+lhessian+10.*lagblock*lagblock';
        lkhessian=1./n.*qdersquared-1./n^2.*lkdermult+lhessian;
        lkhessian=lkhessian+lhessian+10.*lagblock*lagblock';
        tetaiter=teta+10^-6.*(lkhessian^-1)*qhessian*(tetaem-teta);
        tetaiter=tetaiter.^2;
        %lagmult=lagmult+(lagblock.'*lkhessian*lagblock)^-1*h;
        %tetaiter=tetaiterlag(1:F*(dim*alphabet+1)).^2;
        %lagmult=tetaiterlag(F*(dim*alphabet+1)+1:end);
        [lambdaiter,matricesiter]=teta2lm(tetaiter,dim,alphabet,F);
        lambdaiter=projector(lambdaiter,F);
        for j=1:dim
            matricesiter{j} = matrix_projector(matricesiter{j},alphabet,F);
        end
        tetaiter=lm2teta(lambdaiter,matricesiter,dim,alphabet,F);
        teta=teta.^2;
        tetaem=tetaem.^2;
        diff=norm(tetaem-teta)
        if diff<epsilon2
            break;
        end
        teta=tetaiter;
    end
end
iter=i;
matrix=matrices{1};
for i=1:F
    matrix(:,i)=lambda(i).*matrix(:,i);
end
matrices{1}=matrix;%after getting each lambda and matrix. calculate the the pmf via cpd.
pmf=cpdgen(matrices);
end

function [lagblock]=lagblockgen(teta,dim,alphabet,F) % make sure teta is a coloumn vector.
a_values=teta(1:F*dim*alphabet);
a_values=reshape(a_values,[alphabet F*dim]);
lagblock=a_values(:,1);
for i=2:F*dim
    lagblock=blkdiag(lagblock,a_values(:,i));
end
lam_values=teta(F*dim*alphabet+1:end);
lagblock=blkdiag(lagblock,lam_values);
end

function [lhessian]=lhessiangen(lagmult,dim,alphabet,F)
lhessian=lagmult(1)*eye(alphabet);
%size(lagmult)
for i=2:F*dim
    lhessian=blkdiag(lhessian,lagmult(i).*eye(alphabet));
end
lhessian=blkdiag(lhessian,lagmult(F*dim+1).*eye(F));
end
