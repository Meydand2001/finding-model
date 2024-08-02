function [kld,pmf1,pmf2] = kld_accuracy_calc2(lambda1,b_matrices1,a_tensors1,F1,alphabet,M1,g_alphabet1,N,fld1,pmf2,precision)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
pmf1=hm2pmf(lambda1,b_matrices1,a_tensors1,F1,alphabet,M1,g_alphabet1,N,fld1);
pmf2=pmf2.*(pmf2>precision);
kld=nansum(pmf2(:).*log(pmf2(:)./pmf1(:)));
end