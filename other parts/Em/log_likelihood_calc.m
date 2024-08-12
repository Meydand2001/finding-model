function [log_likelihood] = log_likelihood_calc(lambda,matrices,data_set,samples,dim,alphabet,F)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
s=zeros(samples,1);
v=zeros(alphabet,F,dim);
for j=1:dim
    v(:,:,j)=matrices{j};
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
         %vb=v(y,f,:)% needs to be a vector
         ex(f)=lambda(f)*prod(vb);
    end
    s(t)=sum(ex);
end
log_likelihood=sum(log(s));
end