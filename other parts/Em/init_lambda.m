function [lambda] = init_lambda(f)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
lambda = rand(f,1);
sl = sum(lambda);
lambda = lambda./sl;
lambda = projector(lambda,size(lambda,1));
end

