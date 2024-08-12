function [tensors] = init_tensors(number_of_tensors,alphabet,array_of_sizes)
%INIT_TENSORS Summary of this function goes here
%   Detailed explanation goes here
tensors= cell(number_of_tensors,1);
for i=1:number_of_tensors
    tensor = rand([alphabet,array_of_sizes{i}]);
    tensor = tensor./sum(tensor);
    tensors{i,1}=tensor;
end
end

