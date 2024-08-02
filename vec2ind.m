function [ind] = vec2ind(sizes,indvec)
%vec2ind turns an indexing vector to a linear index
multvec=[1;cumprod(sizes)'];
calcvec=indvec-1;
calcvec(:,1)=calcvec(:,1)+1;
ind=calcvec*multvec(1:end-1);
end