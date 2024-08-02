function [b_tensor, c_tensors,c] = shm_em_step(b_tensor,c_tensors,data_set,samples,dim,alphabet,g_alphabet,M,array_of_sizes,fld,opfld,tensor_sizes)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
bgtensormult=zeros([1,size(b_tensor)]);
bgtensormult(1,:)=b_tensor(:);
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
    c_tensor=c_tensors{b};
    total_sub_tensor=ones([samples,tensor_sizes{b}]);
    nb=data_set(:,b)>0;
    ind=find(nb);
    y=data_set(nb,b);
    total_sub_tensor(ind,:)=c_tensor(y,:);
    tensormult=tensormult.*total_sub_tensor;
end
c=tensormult./sum(tensormult,2:M+1);

    %c(t,:)=tensormult(:)./sum(tensormult(:));
%end
ktag = sum(c,1);
N=dim;
ltag=cell(N,1);
for n=1:N
    if isempty(opfld{n})
        interset=c;
    else
        interset=sum(c,opfld{n}+1);
    end
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


b_tensorunorg= ktag./sum(ktag(:));
b_tensor=zeros(g_alphabet);
b_tensor(:)=b_tensorunorg(1,:);
c_tensors=cell(N,1);
for n=1:N
    c_tensors{n} = ltag{n}./sum(ltag{n},1);
end
end