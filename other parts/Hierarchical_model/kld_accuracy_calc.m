function [kld] = kld_accuracy_calc(pmf1,pmf2,precision)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
pmf2=pmf2.*(pmf2>precision);
%kld=nansum(pmf2(:).*log(pmf2(:)./pmf1(:)));
kld_elements=pmf2(:).*log(pmf2(:)./pmf1(:));
kld=sum(kld_elements(find(~isnan(kld_elements))));

end