function [data_set,incomplete_data_set,lambda,a_matrices] = generate_data_set2(samples,N,alphabet,erasure_probability,model_order)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
lambda=init_vector(model_order);
lambda_options=1:model_order;
lambda_samples=randsample(lambda_options,samples,true,lambda)';

a_matrices=init_matrices(N,alphabet*ones(1,N),model_order);
data_set=zeros(samples,N);
for t=1:samples
    for n=1:N
        options=1:alphabet;
        matrix=a_matrices{n};
        data_set(t,n)=randsample(options,1,true,matrix(:,lambda_samples(t)));
    end
end
incomplete_data_set=data_set;
for i=1:samples
    erasure_set=binornd(1,(1-erasure_probability)*ones(1,N));
    while sum(erasure_set)==0
        erasure_set=binornd(1,(1-erasure_probability)*ones(1,N));
    end
    incomplete_data_set(i,:)=data_set(i,:).*erasure_set;
end


end