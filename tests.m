
T=500000;
N=5; alphabet=5;
F=1; M=3; g_alphabet=[2,2,2];
fld=cell(N,1);
fld{1}=[1 2 3]; fld{2}=[1 2]; fld{3}=[1 2]; fld{4}=[3]; fld{5}=[3];
array_of_sizes=cell(N,1);
array_of_sizes{1}=[2 2 2]; array_of_sizes{2}=[2 2]; array_of_sizes{3}=[2 2];
array_of_sizes{4}=[2]; array_of_sizes{5}=[2];
[data_set,incomplete_data_set,lambda_samples,g_samples,lambda,b_matrices,a_tensors] = generate_data_set_hm(T,N,alphabet,F,g_alphabet,M,array_of_sizes,fld,0.2);
data_set_model=cell(7,1);
data_set_model{1}=data_set; data_set_model{2}=incomplete_data_set;
data_set_model{3}=lambda_samples; data_set_model{4}=g_samples;
data_set_model{5}=lambda; data_set_model{6}=b_matrices;
data_set_model{7}=a_tensors;

%{
T=100000;
N=5; alphabet=5;
F=2; M=3; g_alphabet=[2,2,2];
fld=cell(N,1);
fld{1}=[1 2]; fld{2}=[1]; fld{3}=[1 2]; fld{4}=[2 3]; fld{5}=[3];
array_of_sizes=cell(N,1);
array_of_sizes{1}=[2 2]; array_of_sizes{2}=[2]; array_of_sizes{3}=[2 2];
array_of_sizes{4}=[2 2]; array_of_sizes{5}=[2];
[data_set,incomplete_data_set,lambda_samples,g_samples,lambda,b_matrices,a_tensors] = generate_data_set_hm(T,N,alphabet,F,g_alphabet,M,array_of_sizes,fld,0.2);
data_set_model=cell(7,1);
data_set_model{1}=data_set; data_set_model{2}=incomplete_data_set;
data_set_model{3}=lambda_samples; data_set_model{4}=g_samples;
data_set_model{5}=lambda; data_set_model{6}=b_matrices;
data_set_model{7}=a_tensors;
%}
%{
T=200000;
N=4; alphabet=6;
F=2; M=3; g_alphabet=[2,2,2];
fld=cell(N,1);
fld{1}=[1 2 3]; fld{2}=[1 2]; fld{3}=[1 3]; fld{4}=[2 3];
array_of_sizes=cell(N,1);
array_of_sizes{1}=[2 2 2]; array_of_sizes{2}=[2 2]; array_of_sizes{3}=[2 2];
array_of_sizes{4}=[2 2];
[data_set,incomplete_data_set,lambda_samples,g_samples,lambda,b_matrices,a_tensors] = generate_data_set_hm(T,N,alphabet,F,g_alphabet,M,array_of_sizes,fld,0.2);
data_set_model=cell(7,1);
data_set_model{1}=data_set; data_set_model{2}=incomplete_data_set;
data_set_model{3}=lambda_samples; data_set_model{4}=g_samples;
data_set_model{5}=lambda; data_set_model{6}=b_matrices;
data_set_model{7}=a_tensors;
%}
%{
T=200000;
N=6; alphabet=7;
F=2; M=3; g_alphabet=[2,2,2];
fld=cell(N,1);
fld{1}=[1,2,3]; fld{2}=[1,2,3]; fld{3}=[1,2,3]; fld{4}=[1,3]; fld{5}=[1]; fld{6}=[2];
array_of_sizes=cell(N,1);
array_of_sizes{1}=[2,2,2]; array_of_sizes{2}=[2,2,2]; array_of_sizes{3}=[2,2,2];
array_of_sizes{4}=[2,2]; array_of_sizes{5}=[2]; array_of_sizes{6}=[2];
[data_set,incomplete_data_set,lambda_samples,g_samples,lambda,b_matrices,a_tensors] = generate_data_set_hm(T,N,alphabet,F,g_alphabet,M,array_of_sizes,fld,0.2);
data_set_model=cell(7,1);
data_set_model{1}=data_set; data_set_model{2}=incomplete_data_set;
data_set_model{3}=lambda_samples; data_set_model{4}=g_samples;
data_set_model{5}=lambda; data_set_model{6}=b_matrices;
data_set_model{7}=a_tensors;
%}