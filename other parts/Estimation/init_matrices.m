function [matrices] = init_matrices(n,alphabet,f)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
matrices=cell(1,1);
for i=1:n
    matrix = zeros(alphabet,f);
    for j=1:f
        column = rand(alphabet,1);
        sl = sum(column);
        column = column./sl;
        column = projector(column,size(column,1));
        matrix(:,j) = column;
    end
    matrices{1,i}=matrix;
end
end