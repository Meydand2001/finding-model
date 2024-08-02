function [b_tensor,c_tensors,iter,log_likelihood,iteration] = pmf_est_shm_em(data_set,alphabet,g_alphabet,M,array_of_sizes,fld,epsilon,max_iterations)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[samples,dim]=size(data_set); %getting data_set sizes.
b_vector=init_vector(prod(g_alphabet)); %initializing lambda,b_matrices and c_tensors.
b_tensor=mat2tens(b_vector,g_alphabet,1:M);
c_tensors=init_tensors(dim,alphabet,array_of_sizes);
teta=shm2teta(b_tensor,c_tensors,dim);
opfld=cell(dim,1);
for n=1:dim
    opfld{n}=setdiff(1:M,fld{n});
end
tensor_sizes=cell(dim,1);
for n=1:dim
   array=array_of_sizes{n};
   full_sizes=ones(1,M);
   full_sizes(fld{n})=array;
   tensor_sizes{n}=full_sizes;
end
log_likelihood=zeros(1,max_iterations/10+1);
iter=zeros(1,max_iterations/10+1);
sam=1;
for i=1:max_iterations
    if mod(i,10)==1
        log_likelihood(sam)=log_likelihood_calc_shm(b_tensor,c_tensors,data_set,samples,dim,M,tensor_sizes);
        iter(sam)=i-1;
        sam=sam+1;
    end
    [b_tensor, c_tensors]=shm_em_step(b_tensor,c_tensors,data_set,samples,dim,alphabet,g_alphabet,M,array_of_sizes,fld,opfld,tensor_sizes);
    tetatag=shm2teta(b_tensor,c_tensors,dim);
    %norm(tetatag-teta)
    if norm(tetatag-teta)<epsilon
        break;
    end
    teta=tetatag;
end
log_likelihood(sam)=log_likelihood_calc_shm(b_tensor,c_tensors,data_set,samples,dim,M,tensor_sizes);
iter(sam)=i;
iteration=i;
end


function [teta] = shm2teta(b_tensor,c_tensors,N)
%MD2TETA Summary of this function goes here
%   Detailed explanation goes here

teta=b_tensor(:);
for n=1:N
    teta=[teta; c_tensors{n}(:)];
end
end