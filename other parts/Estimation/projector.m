function [vec_p] = projector(vec,n)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
A=ones(1,n);
b=1;
AAt=A*A';
P = eye(n) - A' * (AAt \ A);
q = A' * (AAt \ b);
vec_p = P*vec+q;
end