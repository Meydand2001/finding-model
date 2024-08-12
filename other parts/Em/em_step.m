function [lambda,matrices] = em_step(lambda,matrices,data_set,samples,dim,alphabet,F)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
c=zeros(samples,F);
v=zeros(alphabet,F,dim);
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
end
%c(t,f)=lambda(f)*sum()./sum(lambda*sum());
ctag = sum(c);
ktag=zeros(dim,alphabet,F);
for f=1:F
    for n=1:dim
        for i=1:alphabet
            yn=data_set(:,n)==i;
            ktag(n,i,f)= sum(c(yn,f));
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
end