
samples=200000;
dimension=5;
alphabet=5;
model_order=8;
erasure_probability=0.2;
[data_set,incomplete_data_set,lambda,a_matrices] = generate_data_set2(samples,dimension,alphabet,erasure_probability,model_order);
data_set_model=cell(4,1);
data_set_model{1}=data_set; data_set_model{2}=incomplete_data_set;
data_set_model{3}=lambda; data_set_model{4}=a_matrices;