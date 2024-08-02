function [matrices] = init_matrices(number_of_matrices,g_alphabet,coloumns)
%INIT_MATRICES Summary of this function goes here
%   Detailed explanation goes here
matrices = cell(number_of_matrices,1);
for i=1:number_of_matrices
    matrix = rand(g_alphabet(i),coloumns);
    matrix=matrix./sum(matrix);
    matrices{i}=matrix;
end
end

