function [data_set,incomplete_data_set,pmf] = generate_data_set2(samples,dimension,alphabet,erasure_probability,model_order)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
pmf_size=alphabet.*ones(dimension,1);
u=cpd_rnd(pmf_size,model_order);
for i=1:dimension
    u{i}=matrix_projector(u{i},alphabet,model_order);
end
pmf=cpdgen(u);
pmf=pmf./model_order;
v_pmf=reshape(pmf,[1,alphabet^dimension]);
x=0:alphabet^dimension-1;
t=randsample(x,samples,true,v_pmf);
%data_set = unidrnd(alphabet,samples,dimension);
data_set=zeros(samples,dimension);
incomplete_data_set=data_set;
for i=1:samples
    for j=1:dimension
        data_set(i,j)=mod(floor(t(i)/alphabet^(j-1)),alphabet)+1;
    end
end
for i=1:samples
    erasure_set=binornd(1,(1-erasure_probability)*ones(1,dimension));
    while sum(erasure_set)==0
        erasure_set=binornd(1,(1-erasure_probability)*ones(1,dimension));
    end
    incomplete_data_set(i,:)=data_set(i,:).*erasure_set;
end
%erasure_set=binornd(1,(1-erasure_probability)*ones(samples,dimension));
%incomplete_data_set=data_set.*erasure_set;
end