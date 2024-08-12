function [kl] = kld(p_v1,p_v2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
v_kl=zeros(size(p_v1));
for i=1:size(p_v1,2)
    if p_v1(i)==0 
        v_kl(i)=0;
    else
         v_kl(i)=p_v1(i).*log(p_v1(i)./p_v2(i));
    end
end
kl=sum(v_kl);
end