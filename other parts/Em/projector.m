function [vec_p] = projector(vec,n)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
A=ones(1,n);
b=1;
AAt=A*A';
P = eye(n) - A' * (AAt \ A);
q = A' * (AAt \ b);
vec_p = P*vec+q;
logical_pos=vec_p>=0;
pos= all(logical_pos);
if pos == 0
    count=size(vec(logical_pos),1);
    vec_p(logical_pos)=projector(vec(logical_pos),count);
    vec_p(not(logical_pos))=0;
end
%I need to add a code to deal with negative numbers.
end