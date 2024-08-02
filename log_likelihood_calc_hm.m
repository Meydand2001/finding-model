function [log_likelihood] = log_likelihood_calc_hm(lambda,b_matrices,a_tensors,data_set,samples,dim,F,M,g_alphabet,tensor_sizes)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
c=zeros([samples,1]);
matmult=lambda';
for m=1:M
    matmult=kr(b_matrices{m},matmult);
end
matmult=matmult';
bgtensormult=mat2tens(matmult,[1;F;g_alphabet']',1:2,3:(M+2));
tensormult=repmat(bgtensormult,samples,1);
%{
for t=1:samples
    nb=data_set(t,:)>0;
    ind=find(nb);
    y=data_set(t,nb);
    %tensormult=mat2tens(matmult,[F;g_alphabet']',1,2:(M+1));
    tensormult=bgtensormult;
    %tensormult2=bgtensormult;
    for b=1:size(y,2)
        a_tensor=a_tensors{ind(b)};
        a_subtensor=zeros([1,tensor_sizes{ind(b)}]);
        a_subtensor(1,:)=a_tensor(y(b),:);
        %a_matrix=tens2mat(a_tensor,1,2:(size(array_of_size{ind(b)},2)+1));
        %a_vector=a_tensor(y(b),:)
        %reshaped=tens2mat(tensormult,[1,opfld{ind(b)}+1],fld{ind(b)}+1).*a_vector;
        %tensormult=mat2tens(reshaped,[F;g_alphabet']',[1,opfld{ind(b)}+1],fld{ind(b)}+1);
        tensormult=tensormult.*a_subtensor;
    end
c(t)=log(sum(tensormult(:)));   
end
%}
for b=1:dim
    a_tensor=a_tensors{b};
    total_sub_tensor=ones([samples,1,tensor_sizes{b}]);
    nb=data_set(:,b)>0;
    ind=find(nb);
    y=data_set(nb,b);
    total_sub_tensor(ind,:)=a_tensor(y,:);
    tensormult=tensormult.*total_sub_tensor;
end
c=log(sum(tensormult,2:M+2));
log_likelihood=sum(c(:));
end