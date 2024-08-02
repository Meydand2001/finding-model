load data_set_model2.mat;
S=20;
data_set=data_set_model{2};
data_set_test=data_set(1:20000,:);
N=size(data_set,2);
alphabet=7;
%model_order=size(data_set_model{5},1);
g_alphabet=[2,2,2];
M=size(data_set_model{6},1);
array_of_sizes=data_set_model{7}(:,2);
fld=data_set_model{7}(:,3);
max_iterations=1500; epsilon=2*10^-4;
tries=1;
model_order=8;
model_order_hm=2;
lambda=data_set_model{5};
b_matrices=data_set_model{6};
c_tensors=data_set_model{7}(:,1);
pmf=hm2pmf(lambda,b_matrices,c_tensors,model_order_hm,alphabet,M,g_alphabet,N,fld);
TH = 6;
kld_accuracy = zeros(S,TH);
mre = zeros(S,TH);
threshold=[0.01,0.025,0.05,0.1,0.25,0.5];
for s=1:S
    for th = 1:TH
         [array_of_sizes_est,fld_est] = find_fld(data_set_test,alphabet,model_order,N,epsilon,max_iterations,tries,threshold(th));
        [b_tensor_est,c_tensors_est,~,~,~] = pmf_est_shm_em(data_set_test,alphabet,g_alphabet,M,array_of_sizes_est,fld_est,epsilon,max_iterations);
        pmf_est=shm2pmf(b_tensor_est,c_tensors_est,alphabet,M,g_alphabet,N,fld_est);
        kld_accuracy(s,th)=kld_accuracy_calc(pmf,pmf_est,10^-7);
        mre(s,th)=mre_accuracy_calc(pmf,pmf_est);
    end
end