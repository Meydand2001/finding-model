function [lambda, b_matrices, a_tensors,c] = hm_em_oracle_step(data_set,samples,dim,lambda_samples,g_samples,alphabet,F,g_alphabet,M,fld,opfld)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
c=zeros([samples,F,g_alphabet]);
t=1:samples;
lambdag=[t',lambda_samples,g_samples];
indices=vec2ind([samples,F,g_alphabet],lambdag);
c(indices)=1;
    %c(t,:)=tensormult(:)./sum(tensormult(:));
%end
ctag = sum(c,[1,3:M+2]);
ktag=cell(M,1);
for m=1:M
    if m==1
        tensor=sum(c,[1,4:M+2]);
    elseif m==M
        tensor=sum(c,[1,3:M+1]);
    else
        tensor=sum(c,[1,3:m+1,m+3:M+2]);
    end
    ktag{m}=tens2mat(tensor,3:(m+2),[1 2]);
end
N=dim;
ltag=cell(N,1);
for n=1:N
    interset=sum(c,[2,opfld{n}+2]);
    size(interset);
    ltagset=zeros([alphabet,g_alphabet(fld{n})]);
   % size(ltagset)
    for i=1:alphabet
         indices=find(data_set(:,n)==i);
        % size(indices)
        ltagset(i,:)=sum(interset(indices,:),1);
    end
    ltag{n}=ltagset;
end


lambda = ctag./sum(ctag);
lambda=lambda';
b_matrices = cell(M,1);
for m=1:M
    b_matrices{m} = ktag{m}./sum(ktag{m},1);
end
a_tensors=cell(N,1);
for n=1:N
    a_tensors{n} = ltag{n}./sum(ltag{n},1);
end
end