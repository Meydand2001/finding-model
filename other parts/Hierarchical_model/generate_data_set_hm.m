function [data_set,incomplete_data_set,lambda_samples,g_samples,lambda,b_matrices,a_tensors] = generate_data_set_hm(samples,dimension,alphabet,model_order,g_alphabet,M,array_of_sizes,fld,erasure_probability)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
lambda=init_vector(model_order);
lambda_options=1:model_order;
lambda_samples=randsample(lambda_options,samples,true,lambda)';

b_matrices=init_matrices(M,g_alphabet,model_order);
g_samples=zeros(samples,M);
for t=1:samples
    for m=1:M
        g_options=1:g_alphabet(m);
        matrix=b_matrices{m};
        g_samples(t,m)=randsample(g_options,1,true,matrix(:,lambda_samples(t)));
    end
end
a_tensors=init_tensors(dimension,alphabet,array_of_sizes);
a_options=1:alphabet;
data_set=zeros(samples,dimension);
for t=1:samples
    for i=1:dimension
        tensor=a_tensors{i,1};
        tensor_sizes=array_of_sizes{i,1};
        tensor_fld=fld{i,1};
        state_vec=g_samples(t,tensor_fld);
        reshaped_tensor=reshape(tensor,[alphabet,prod(tensor_sizes)]);
        data_set(t,i)=randsample(a_options,1,true,reshaped_tensor(:,indg(state_vec,tensor_sizes)));
    end
end    
a_tensors(:,2)=array_of_sizes;
a_tensors(:,3)=fld;
incomplete_data_set=data_set;
for i=1:samples
    erasure_set=binornd(1,(1-erasure_probability)*ones(1,dimension));
    while sum(erasure_set)==0
        erasure_set=binornd(1,(1-erasure_probability)*ones(1,dimension));
    end
    incomplete_data_set(i,:)=data_set(i,:).*erasure_set;
end

end


function [int]=indg(indvec,size_vector)
    cumint=cumprod(size_vector());
    used_vector=[1;cumint(1:end-1)'];
    indvec(1)=indvec(1)+1;
    int=(indvec-1)*used_vector;
end

