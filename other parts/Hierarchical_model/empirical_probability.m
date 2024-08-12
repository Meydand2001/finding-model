function [pmf] = empirical_probability(data_set,alphabet)
%empirical_probability estimations the pmf of a given
% complete data set and the alphabet size of its random variables.
[samples,dim]=size(data_set);
pmf=zeros(alphabet.*ones(1,dim));
indices=vec2ind(alphabet.*ones(1,dim),data_set);
for t=1:samples
    pmf(indices(t))=pmf(indices(t))+1;
end    
pmf=pmf./sum(pmf(:));
end