kld_v=zeros(5,1);
itera=zeros(5,1);
pmf=ones(4,4,4,4)./256;
v=reshape(pmf,[1,256]);
for j=1:5
    kl=0;
    for i=1:5
         [data_set,incompleted_data_set] = generate_data_set(1000*j,4,4,0.1);
         [pmf2,itera(j)]=pmf_est_Em(data_set,4,1,20);
         %v=reshape(pmf,[1,3125]);
         v2=reshape(pmf2,[1,256]);
         kl=kl+kld(v,v2);
    end
    kld_v(j)=kl/5;
end
plot(1:5,kld_v);
hold on
plot(1:5,itera);