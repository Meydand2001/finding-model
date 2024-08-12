function [lambda,matrices, qhessian, qdersquared, lkdermult] = em_step_4(lambda,matrices,data_set,samples,dim,alphabet,F)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
c=zeros(samples,F);
v=zeros(alphabet,F,dim);
hessian_diag=zeros(F*(dim*alphabet+1),1);
qdersquared=zeros(F*(dim*alphabet+1));
lkder=zeros(F*(dim*alphabet+1),1);
qdert=zeros(F*(dim*alphabet+1),1);
for j=1:dim
    v(:,:,j)=matrices{j};%do this transform at the begining.
end
for  t=1:samples
    nb=data_set(t,:)>0;
    ind=find(nb);
    y=data_set(t,nb);
    ex=zeros(F,1);
    for f=1:F
         vb=zeros(size(y,2),1);
         for b=1:size(y,2)
             vb(b)=v(y(b),f,ind(b));
         end
         %ex=zeros(F,1);
         ex(f)=lambda(f)*prod(vb);
    end
    s=sum(ex);
    c(t,:)=ex./s;
    qdert(F*(dim*alphabet)+1:end)=2*c(t,:).'./sqrt(lambda);
    for f=1:F
        for n=1:dim
            for i=1:alphabet
                if data_set(t,n)==i
                    qdert((n-1)*alphabet*F+(f-1)*alphabet+i) = 2*c(t,f)./sqrt(v(i,f,n));
                end 
            end
        end    
    end
    qdersquared=qdersquared+qdert*qdert.';
end
%c(t,f)=lambda(f)*sum()./sum(lambda*sum());
ctag = sum(c);
hessian_diag((F*dim*alphabet+1):end)=2*ctag.'./(lambda);
lkder(F*(dim*alphabet)+1:end)=2*ctag.'./(sqrt(lambda));%+2*L(F*dim+1).*lambda;

ktag=zeros(dim,alphabet,F);
for f=1:F
    for n=1:dim
        for i=1:alphabet
            yn=data_set(:,n)==i;
            ktag(n,i,f) = sum(c(yn,f));
            hessian_diag((n-1)*alphabet*F+(f-1)*alphabet+i) = 2*ktag(n,i,f)./(v(i,f,n));
            lkder((n-1)*alphabet*F+(f-1)*alphabet+i) = 2*ktag(n,i,f)./sqrt(v(i,f,n));%+2*L((n-1)*F+f)*sqrt(v(i,f,n));
        end
    end    
end


lambda=ctag./sum(ctag);
lambda=lambda';
for n=1:dim
    An=zeros(alphabet,F);
    for f=1:F
        for i=1:alphabet
            An(i,f)=ktag(n,i,f)/sum(ktag(n,:,f));
        end
    end
    matrices{n}=An;
end
%hessian_diag(hessian_diag==0)=1;
%hessian_diag=hessian_diag+eye(130);
%hessian_diag=hessian_diag./sum(hessian_diag);
qhessian=diag(hessian_diag);
%qdersquared=qdersquared+eye(130);
lkdermult=lkder*lkder.';
end