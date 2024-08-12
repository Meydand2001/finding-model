%{
N=100;
r=zeros(100,5);
for j=5:9
    for i=1:N
        U=cpd_rnd([5 5 5 5 5],j);
        T=cpdgen(U);
        r(i,j-4)=rankest(T);
    end
end
%}
load data_set_model_test5.mat;
N=5;
alphabet=5;
model_order=size(data_set_model{5},1);
g_alphabet=[2,3];
M=size(data_set_model{6},1);
array_of_sizes=data_set_model{7}(:,2);
fld=data_set_model{7}(:,3);
lambda1=data_set_model{5};
b_matrices1=data_set_model{6};
a_tensors1=data_set_model{7}(:,1);
pmf1=hm2pmf(lambda1,b_matrices1,a_tensors1,model_order,alphabet,M,g_alphabet,N,fld);
S=20;
r=zeros(S,1);
for i=1:S       
    r(i)=rankest(pmf1);
end