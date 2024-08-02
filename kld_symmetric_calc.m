function [kld_symmetric] = kld_symmetric_calc(pmf1,pmf2)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
kld_symmetric=(kld_calc(pmf1,pmf2)+kld_calc(pmf2,pmf1))/2;
end