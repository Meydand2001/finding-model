function [lambda, b_matrices, a_tensors,c] = hm_em_step(lambda,b_matrices,a_tensors,data_set,samples,dim,alphabet,F,g_alphabet,M,array_of_sizes,fld,opfld,tensor_sizes)
%HM_EM Summary of this function goes here
%   Detailed explanation goes here
c=zeros([samples,F,g_alphabet]);
matmult=lambda';
for m=1:M
    matmult=kr(b_matrices{m},matmult);
end
matmult=matmult';
bgtensormult=mat2tens(matmult,[1;F;g_alphabet']',1:2,3:(M+2));
tensormult=repmat(bgtensormult,samples,1);
%nb=data_set(:,:)>0;
%y=data_set(nb);
%for t=1:samples
    %nb=data_set(t,:)>0;
    %ind=find(nb(t,:));
    %y=data_set(t,nb);
    %tensormult=mat2tens(matmult,[F;g_alphabet']',1,2:(M+1));
    %tensormult=bgtensormult;
    %tensormult2=bgtensormult;
    %for b=1:size(ind,2)
for b=1:dim
    a_tensor=a_tensors{b};
    total_sub_tensor=ones([samples,1,tensor_sizes{b}]);
    nb=data_set(:,b)>0;
    ind=find(nb);
    y=data_set(nb,b);
    total_sub_tensor(ind,:)=a_tensor(y,:);
    tensormult=tensormult.*total_sub_tensor;
end
c=tensormult./sum(tensormult,2:M+2);

    %c(t,:)=tensormult(:)./sum(tensormult(:));
%end
ctag = sum(c,[1,3:M+2]);
ktag=cell(m,1);
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

