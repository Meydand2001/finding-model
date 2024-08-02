function [kld] = kld_calc(v1,mv2)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
mv2=mv2.*(mv2>10^-7);
kld_elements=mv2.*log(mv2./v1);
kld=sum(kld_elements(find(~isnan(kld_elements))));
end