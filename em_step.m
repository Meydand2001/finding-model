function [lambda,matrices] = em_step(lambda,matrices,data_set,samples,dim,alphabet,F)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
c=zeros(samples,F);
vectormult=repmat(lambda',samples,1);
for b=1:dim
    matrix=matrices{b};
    total_sub_matrix=ones([samples,F]);
    nb=data_set(:,b)>0;
    ind=find(nb);
    y=data_set(nb,b);
    total_sub_matrix(ind,:)=matrix(y,:);
    vectormult=vectormult.*total_sub_matrix;
end
c=vectormult./sum(vectormult,2);

ctag = sum(c);
ktag=zeros(dim,alphabet,F);
%{
for f=1:F
    for n=1:dim
        for i=1:alphabet
            yn=data_set(:,n)==i;
            ktag(n,i,f)= sum(c(yn,f));
        end
    end    
end
%}
for n=1:dim
    for i=1:alphabet
        yn=data_set(:,n)==i;
        ktag(n,i,:)= sum(c(yn,:),1);
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