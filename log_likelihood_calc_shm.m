function [log_likelihood] = log_likelihood_calc_shm(b_tensor,c_tensors,data_set,samples,dim,M,tensor_sizes)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
bgtensormult=zeros([1,size(b_tensor)]);
bgtensormult(1,:)=b_tensor(:);
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
    c_tensor=c_tensors{b};
    total_sub_tensor=ones([samples,tensor_sizes{b}]);
    nb=data_set(:,b)>0;
    ind=find(nb);
    y=data_set(nb,b);
    total_sub_tensor(ind,:)=c_tensor(y,:);
    tensormult=tensormult.*total_sub_tensor;
end
c=log(sum(tensormult,2:M+1));
log_likelihood=sum(c(:));
end