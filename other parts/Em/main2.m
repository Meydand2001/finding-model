
kld_v=zeros(5,1);
itera=zeros(5,1);
for j=1:5
    kl=0;
    for i=1:20
         [data_set,incompleted_data_set,pmf] = generated_data_set2(300*2^(j-1),3,5,0.1,3);
         [pmf2,itera(j)]=pmf_est_Em(data_set,5,3,200);
         v=reshape(pmf,[1,125]);
         v2=reshape(pmf2,[1,125]);
         kl=kl+kld(v,v2);
    end
    kld_v(j)=kl/20;
end
subplot(1,2,1);
plot(1:5,kld_v);
subplot(1,2,2);
plot(1:5,itera);






